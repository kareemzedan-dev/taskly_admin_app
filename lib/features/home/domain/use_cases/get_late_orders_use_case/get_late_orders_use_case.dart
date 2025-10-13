import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';
import '../../repos/late_orders_repo/late_orders_repo.dart';
@injectable
class GetLateOrdersUseCase {
   final LateOrdersRepo lateOrdersRepo;
   GetLateOrdersUseCase(this.lateOrdersRepo);
   Future<Either<Failures, List<OrderEntity>>> call() async {
     return await lateOrdersRepo.getLateOrders();
   }
}