import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/subscribe_to_messages_remote_data_source_impl/subscribe_to_messages_remote_data_source.dart';
import 'package:taskly_admin/features/home/data/models/message_model/message_model.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';

@Injectable(as: SubscribeToMessagesRemoteDataSource)
class SubscribeToMessagesRemoteDataSourceImpl implements SubscribeToMessagesRemoteDataSource {
  final SupabaseService supabaseService;

  SubscribeToMessagesRemoteDataSourceImpl(this.supabaseService);

  Stream<List<MessageEntity>> subscribeToMessages({
    required String senderId,
    required String receiverId,
  }) {
    final stream = supabaseService.supabaseClient
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((records) {
      final unique = <String, MessageEntity>{};
      for (final record in records) {
        final msg = MessageModel.fromJson(record).toEntity();
        if ((msg.senderId == senderId && msg.receiverId == receiverId) ||
            (msg.senderId == receiverId && msg.receiverId == senderId)) {
          unique[msg.id] = msg;
        }
      }
      final list = unique.values.toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return list;
    });

    return stream;
  }


}
