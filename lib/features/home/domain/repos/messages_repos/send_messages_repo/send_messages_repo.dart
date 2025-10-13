
import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';

abstract class SendMessagesRepo {
  Future<Either<Failures, MessageEntity>> sendMessage(  MessageEntity message,{String? orderId});

}