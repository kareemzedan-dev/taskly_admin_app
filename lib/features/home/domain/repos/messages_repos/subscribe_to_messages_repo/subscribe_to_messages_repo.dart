import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';

abstract class  SubscribeToMessagesRepo {
  Stream<List<MessageEntity>> subscribeToMessages({
    required String senderId,
    required String receiverId,

  });

}