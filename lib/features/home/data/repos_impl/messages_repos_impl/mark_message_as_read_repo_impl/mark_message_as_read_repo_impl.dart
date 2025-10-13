import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/mark_messages_as_read_remote_data_source_impl/mark_messages_as_read_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/mark_message_as_read_repo/mark_message_as_read_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:  MarkMessageAsReadRepo)
class MarkMessageAsReadRepoImpl implements MarkMessageAsReadRepo{
  final MarkMessagesAsReadRemoteDataSource remoteDataSource;
  MarkMessageAsReadRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> markMessagesAsRead(String orderId) {
    return remoteDataSource.markMessagesAsRead(orderId);
  }


}
