import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_all_order_messages_repo/get_all_order_messages_repo.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';
import '../../../presentation/views/tabs/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart';

@injectable
class GetAcceptedOrderMessagesUseCase {
  final GetAllOrderMessagesRepo repository;

  GetAcceptedOrderMessagesUseCase(this.repository);

  Future<Either<Failures, List<OrderEntity>>> call(String userId,UserRole role) {
    return repository.getAllOrderMessages(userId,role);
  }
}
