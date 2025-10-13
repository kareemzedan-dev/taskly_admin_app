import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/cache/app_cache_manager.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/get_chat_messages_remote_data_source_impl/get_chat_messages_remote_data_source.dart';
import 'package:taskly_admin/features/home/data/models/message_model/message_model.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';

@Injectable(as: GetChatMessagesRemoteDataSource)
class GetChatMessagesRemoteDataSourceImpl
    implements GetChatMessagesRemoteDataSource {
  final SupabaseService supabaseService;
  static const messagesCachePrefix = 'messages_';

  GetChatMessagesRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<MessageEntity>>> getMessages({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(ServerFailure('No internet connection'));
      }

      print('Fetching messages for: $senderId -> $receiverId');

      final response = await supabaseService.supabaseClient
          .from('messages')
          .select()
          .or(
        'and(sender_id.eq.$senderId,receiver_id.eq.$receiverId),and(sender_id.eq.$receiverId,receiver_id.eq.$senderId)',
      )
          .order('created_at', ascending: true);

      print('Raw response from supabase: ${response.length} messages');

      final messages = (response as List)
          .map((e) {
        try {
          final jsonMap = Map<String, dynamic>.from(e);
          final message = MessageModel.fromJson(jsonMap).toEntity();
          print('Parsed message: ${message.id} - ${message.content}');
          return message;
        } catch (e) {
          print('Error parsing message: $e, data: $e');
          return null;
        }
      })
          .where((element) => element != null)
          .cast<MessageEntity>()
          .toList();

      print('Successfully parsed ${messages.length} messages');

      return Right(messages);
    } on PostgrestException catch (e) {
      print('Postgrest error: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('General error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}