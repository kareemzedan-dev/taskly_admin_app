import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/order_entity/order_entity.dart';


abstract class LateOrdersRemoteDataSource {
  Future<Either<Failures, List<OrderEntity>>> getLateOrders();
}