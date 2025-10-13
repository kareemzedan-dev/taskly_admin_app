import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_messages_repo/get_messages_repo.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_orders_conversions_repo/get_orders_conversions_repo.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/subscribe_to_messages_repo/subscribe_to_messages_repo.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/message_entity/message_entity.dart';

@injectable
class GetOrderMessagesUseCase {
  final GetMessagesRepo repository;
  final SubscribeToMessagesRepo subscribeToMessagesRepo;

  GetOrderMessagesUseCase(this.repository , this.subscribeToMessagesRepo);


  Future<Either<Failures, List<MessageEntity>>> call({
    required String senderId,
    required String receiverId,
  }) {
    return repository.getMessages(senderId: senderId, receiverId: receiverId);
  }


  Stream<List<MessageEntity>>  callSubscribe({
    required String senderId,
    required String receiverId,
  })   {
    try {
     return subscribeToMessagesRepo.subscribeToMessages(senderId: senderId, receiverId: receiverId, );
    } catch (e) {
      throw ServerFailure('Subscription failed: $e');
    }
  }
}
