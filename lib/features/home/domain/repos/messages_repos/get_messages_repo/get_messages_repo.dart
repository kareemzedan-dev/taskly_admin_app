import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';

abstract class  GetMessagesRepo {
  Future<Either<Failures, List<MessageEntity>>> getMessages({
    required String senderId,
    required String receiverId,
  });
}