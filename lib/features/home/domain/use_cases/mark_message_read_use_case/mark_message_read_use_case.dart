import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/mark_message_as_read_repo/mark_message_as_read_repo.dart';
import '../../../../../core/errors/failures.dart';

@lazySingleton
class MarkMessagesAsReadUseCase {
  final MarkMessageAsReadRepo repository;

  MarkMessagesAsReadUseCase(this.repository);

  Future<Either<Failures, void>> call(String orderId) {
    return repository.markMessagesAsRead(orderId);
  }
}
