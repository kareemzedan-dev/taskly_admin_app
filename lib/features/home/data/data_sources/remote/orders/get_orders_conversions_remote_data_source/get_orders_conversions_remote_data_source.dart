import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

 
abstract class GetOrdersConversionsRemoteDataSource {
  Future<Either<Failures, List<OrderEntity>>> getOrdersConversations();
}