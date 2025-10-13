import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

abstract class GetOrdersConversionsRepo {
  Future<Either<Failures, List<OrderEntity>>>  getOrdersConversations();
}