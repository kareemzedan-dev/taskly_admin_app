import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/message_validator.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/send_message_remote_data_source_impl/send_message_remote_data_source.dart';
import 'package:taskly_admin/features/home/data/models/message_model/message_model.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';
import 'package:uuid/uuid.dart';
@Injectable(as: SendMessageRemoteDataSource)
class SendMessageRemoteDataSourceImpl implements SendMessageRemoteDataSource{
  final SupabaseService supabase;

  SendMessageRemoteDataSourceImpl(this.supabase);


  @override
  Future<Either<Failures, MessageEntity>> sendMessage(
      MessageEntity message, {
        String? orderId,
      }) async {
    try {
      if(!await NetworkUtils.hasInternet()){
        return Left(ServerFailure('No internet connection'));
      }
      final String generatedId = const Uuid().v4();

      String? paymentId;
      if (orderId != null) {
        final paymentResponse =
        await supabase.supabaseClient.from('payments').select('id').eq('order_id', orderId).maybeSingle();
        paymentId = paymentResponse != null ? paymentResponse['id'] as String : null;
      }

      if (MessageValidator.hasForbiddenContent(message.content)) {
        return Left(ServerFailure(
          "Message contains forbidden content (numbers or external links)",
        ));
      }

      if (message.senderType != 'admin') {
        if (message.senderType == 'client' && message.receiverType != 'freelancer') {
          return Left(ServerFailure("Client can only message its freelancer"));
        }
        if (message.senderType == 'freelancer' && message.receiverType != 'client') {
          return Left(ServerFailure("Freelancer can only message its client"));
        }
      }

      final response = await supabase.supabaseClient.from('messages').insert({
        'id': generatedId,
        'order_id': orderId,
        'sender_id': message.senderId,
        'receiver_id': message.receiverId,
        'payment_id': paymentId,
        'message_type': message.messageType,
        'content': message.content,
        'attachment': message.attachment != null
            ? jsonEncode(message.attachment!.map((e) => e.toJson()).toList())
            : null,
        'status': message.status,
        'sender_type': message.senderType,
        'receiver_type': message.receiverType,
        'created_at': message.createdAt.toIso8601String(),
        'updated_at': message.updatedAt.toIso8601String(),
      }).select().single();

      return Right(MessageModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}