import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/get_chat_messages_remote_data_source_impl/get_chat_messages_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';

import '../../../../domain/repos/messages_repos/get_messages_repo/get_messages_repo.dart';
@Injectable(as:  GetMessagesRepo)
class GetMessagesRepoImpl implements GetMessagesRepo {
  final GetChatMessagesRemoteDataSource remoteDataSource;
  GetMessagesRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, List<MessageEntity>>> getMessages({required String senderId, required String receiverId}) {
   return remoteDataSource.getMessages(senderId: senderId, receiverId: receiverId);
  }

}