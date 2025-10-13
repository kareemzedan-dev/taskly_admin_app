import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../../repositories/attachments_repository/attachments_repository.dart';
@injectable
class DeleteAttachmentsUseCase {
  final AttachmentsRepository attachmentsRepository;

  DeleteAttachmentsUseCase({required this.attachmentsRepository});

  Future<Either<Failures, void>> callDeleteAttachment(
      String attachmentId, {
        String? bucketName,
      }) =>
      attachmentsRepository.deleteAttachment(attachmentId, bucketName: bucketName);
}
