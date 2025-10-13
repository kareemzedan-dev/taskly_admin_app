import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/send_messages_repo/send_messages_repo.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/message_entity/message_entity.dart';

@lazySingleton
class SendMessageUseCase {
  final SendMessagesRepo repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failures, MessageEntity>> call(  MessageEntity message,{String? orderId}) {
    return repository.sendMessage(  message,orderId: orderId);
  }

}
