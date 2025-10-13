import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/attachment_entity/attaachments_entity.dart';
import '../../repositories/attachments_repository/attachments_repository.dart';

@injectable
class UploadAttachmentsUseCase {
  final AttachmentsRepository attachmentsRepository;

  UploadAttachmentsUseCase({required this.attachmentsRepository});

  /// Upload files with optional [bucketName] for flexibility
  Future<Either<Failures, List<AttachmentEntity>>> callUploadAttachments(
      List<File> files, {
        String? bucketName,
      }) =>
      attachmentsRepository.uploadAttachments(
        files,
        bucketName: bucketName,
      );
}
