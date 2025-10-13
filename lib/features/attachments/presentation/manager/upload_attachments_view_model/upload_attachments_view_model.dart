import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/attachments/data/models/attachments_dm/attachments_dm.dart';
import 'package:taskly_admin/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/attachment_entity/attaachments_entity.dart';
import '../../../domain/use_cases/upload_attachments/upload_attachments_use_case.dart';

@injectable
class UploadAttachmentsViewModel extends Cubit<UploadAttachmentsViewModelStates> {
  UploadAttachmentsViewModel(this.uploadAttachmentsUseCase)
      : super(UploadAttachmentsViewModelStatesInitial());

  final UploadAttachmentsUseCase uploadAttachmentsUseCase;

  /// الملفات اللي المستخدم اختارها حاليا
  List<File> files = [];

  /// الـ Hash بتاع الملفات اللي اترفعت فعلا في نفس الجلسة
  final Set<String> uploadedFileHashes = {};

  /// ماب بتربط كل ملف بـ Key فريد
  final Map<File, String> _fileKeys = {};
  int _fileCounter = 0;

  /// الملفات اللي اترفعت
  List<AttachmentModel> uploadedAttachments = [];

  String generateFileKey(File file) {
    if (!_fileKeys.containsKey(file)) {
      _fileKeys[file] =
      'file_${_fileCounter++}_${DateTime.now().millisecondsSinceEpoch}';
    }
    return _fileKeys[file]!;
  }

  Future<String> generateFileHash(File file) async {
    final fileName = file.path.split('/').last;
    final fileSize = await file.length();
    return '$fileName-$fileSize';
  }

  /// ✅ اختيار ملف من الجهاز ورفعه مباشرة
  Future<void> pickFilesFromDevice({
    String? bucketName,
    bool singleFileMode = false,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final platformFile = result.files.first;

        if (platformFile.path != null) {
          final file = File(platformFile.path!);

          final fileHash = await generateFileHash(file);

          // ✅ فقط تأكد إنه مش في قائمة الملفات الحالية (مش المرفوعة)
          final alreadySelected = await Future.wait(files.map(generateFileHash))
              .then((hashes) => hashes.contains(fileHash));

          if (alreadySelected) return;

          if (singleFileMode) files.clear();

          files.add(file);
          generateFileKey(file);

          emit(UploadAttachmentsViewModelStatesInitial());

          await uploadAttachments(bucketName: bucketName);
        }
      }
    } catch (e) {
      emit(UploadAttachmentsViewModelStatesError(message: e.toString()));
    }
  }

  /// ✅ حذف ملف من الكيو الحالي
  Future<void> removeFileFromQueue(File file) async {
    final fileHash = await generateFileHash(file);
    files.remove(file);
    _fileKeys.remove(file);
    uploadedFileHashes.remove(fileHash);
    uploadedAttachments.removeWhere(
          (e) => e.name == file.path.split('/').last,
    );
    emit(UploadAttachmentsViewModelStatesInitial());
  }

  /// ✅ رفع الملفات مع تتبع التقدم
  /// ✅ رفع الملفات مع تتبع التقدم
  Future<Either<Failures, List<AttachmentEntity>>> uploadAttachments({
    String? bucketName,
  }) async {
    try {
      emit(UploadAttachmentsViewModelStatesLoading());

      final newFiles = <File>[];

      for (final file in files) {
        final hash = await generateFileHash(file);
        if (!uploadedFileHashes.contains(hash)) {
          newFiles.add(file);
        }
      }

      if (newFiles.isEmpty) {
        // استخدم حالة Initial بدلاً من Error عندما لا توجد ملفات جديدة
        emit(UploadAttachmentsViewModelStatesInitial());
        return const Right([]);
      }

      // محاكاة تقدم الرفع
      for (final file in newFiles) {
        for (double progress = 0.0; progress <= 1.0; progress += 0.1) {
          await Future.delayed(const Duration(milliseconds: 100));
          emit(UploadAttachmentsViewModelStatesUploading(
            file: file,
            progress: progress,
          ));
        }
      }

      final result = await uploadAttachmentsUseCase.callUploadAttachments(
        newFiles,
        bucketName: bucketName,
      );

      return result.fold(
            (failure) {
          emit(UploadAttachmentsViewModelStatesError(
            message: failure.message,
            file: newFiles.isNotEmpty ? newFiles.first : null,
          ));
          return Left(failure);
        },
            (attachments) async {
          for (final file in newFiles) {
            final hash = await generateFileHash(file);
            uploadedFileHashes.add(hash);
          }

          uploadedAttachments.addAll(
            attachments.map((e) => AttachmentModel(
              id: e.id,
              name: e.name,
              size: e.size,
              type: e.type,
              url: e.url,
              storagePath: e.storagePath,
            )),
          );

          emit(UploadAttachmentsViewModelStatesSuccess(
            attachments: attachments,
            file:  newFiles.first,
          ));

          return Right(attachments);
        },
      );
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(UploadAttachmentsViewModelStatesError(
        message: failure.message,
        file: files.isNotEmpty ? files.first : null, // أضف file هنا أيضاً
      ));
      return Left(failure);
    }
  }

  /// ✅ رفع ملف واحد مع تتبع التقدم
  Future<Either<Failures, AttachmentEntity>> uploadSingleAttachment(
      File file, {
        required String bucketName,
      }) async {
    try {
      emit(UploadAttachmentsViewModelStatesLoading());

      // محاكاة تقدم الرفع للملف الواحد
      for (double progress = 0.0; progress <= 1.0; progress += 0.1) {
        await Future.delayed(const Duration(milliseconds: 150));
        emit(UploadAttachmentsViewModelStatesUploading(
          file: file,
          progress: progress,
        ));
      }

      final result = await uploadAttachmentsUseCase.callUploadAttachments(
        [file],
        bucketName: bucketName,
      );

      return result.fold(
            (failure) {
          emit(UploadAttachmentsViewModelStatesError(
            message: failure.message,
            file: file,
          ));
          return Left(failure);
        },
            (attachments) async {
          final hash = await generateFileHash(file);
          uploadedFileHashes.add(hash);

          final attachment = attachments.first;
          uploadedAttachments.add(AttachmentModel(
            id: attachment.id,
            name: attachment.name,
            size: attachment.size,
            type: attachment.type,
            url: attachment.url,
            storagePath: attachment.storagePath,
          ));

          emit(UploadAttachmentsViewModelStatesSuccess(
            attachments: attachments,
            file: file,
          ));

          return Right(attachment);
        },
      );
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(UploadAttachmentsViewModelStatesError(
        message: failure.message,
        file: file,
      ));
      return Left(failure);
    }
  }

  /// ✅ تنظيف الملفات اللي لسه متخزنتش
  Future<void> clearFiles() async {
    final List<File> filesToKeep = [];
    for (final file in files) {
      final hash = await generateFileHash(file);
      if (uploadedFileHashes.contains(hash)) {
        filesToKeep.add(file);
      }
    }
    files = filesToKeep;
    emit(UploadAttachmentsViewModelStatesInitial());
  }

  /// ✅ تنظيف كل الملفات من الذاكرة
  void clearAllFiles() {
    files.clear();
    uploadedFileHashes.clear();
    _fileKeys.clear();
    _fileCounter = 0;
    emit(UploadAttachmentsViewModelStatesInitial());
  }
}