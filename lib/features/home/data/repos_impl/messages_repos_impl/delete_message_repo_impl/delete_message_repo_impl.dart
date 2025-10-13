import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/delete_message_remote_data_source/delete_message_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/delete_message_repo/delete_message_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:  DeleteMessageRepo)

class DeleteMessageRepoImpl implements DeleteMessageRepo{
  final DeleteMessageRemoteDataSource messagesRemoteDataSource;
  DeleteMessageRepoImpl(this.messagesRemoteDataSource);
  @override
  Future<Either<Failures, void>> deleteMessage(String messageId) {
    return messagesRemoteDataSource.deleteMessage(messageId);
  }
}