import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/subscribe_to_messages_remote_data_source_impl/subscribe_to_messages_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/subscribe_to_messages_repo/subscribe_to_messages_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:  SubscribeToMessagesRepo)
class SubscribeToMessagesRepoImpl implements SubscribeToMessagesRepo{
  final SubscribeToMessagesRemoteDataSource subscribeToMessagesRemoteDataSource;
  SubscribeToMessagesRepoImpl(this.subscribeToMessagesRemoteDataSource);

  @override
  Stream<List<MessageEntity>>  subscribeToMessages({
    required String senderId,
    required String receiverId,

  }) {
    return subscribeToMessagesRemoteDataSource.subscribeToMessages(
      senderId: senderId,
      receiverId: receiverId,

    );
  }
}