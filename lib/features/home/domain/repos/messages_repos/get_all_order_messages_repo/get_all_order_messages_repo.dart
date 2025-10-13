import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart';

abstract class GetAllOrderMessagesRepo {
  Future<Either<Failures, List<OrderEntity>>> getAllOrderMessages(String userId,UserRole role);

}