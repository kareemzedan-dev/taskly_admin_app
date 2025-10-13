import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/send_message_remote_data_source_impl/send_message_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/send_messages_repo/send_messages_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:  SendMessagesRepo)
class SendMessagesRepoImpl implements SendMessagesRepo{
  final SendMessageRemoteDataSource sendMessageRemoteDataSource;
  SendMessagesRepoImpl(this.sendMessageRemoteDataSource);
  @override
  Future<Either<Failures, MessageEntity>> sendMessage( MessageEntity message,{String? orderId}) {
    return sendMessageRemoteDataSource.sendMessage(message ,orderId: orderId);
  }
}