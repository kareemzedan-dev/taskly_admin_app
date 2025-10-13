import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly_admin/core/errors/failures.dart';

import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

import '../../../domain/repos/late_orders_repo/late_orders_repo.dart';
import '../../data_sources/remote/orders/late_orders_remote_data_source/late_orders_remote_data_source.dart';
@Injectable(as:  LateOrdersRepo)
class LateOrdersRepoImpl implements LateOrdersRepo {
  final LateOrdersRemoteDataSource lateOrdersRemoteDataSource;
  LateOrdersRepoImpl(this.lateOrdersRemoteDataSource);

  @override
  Future<Either<Failures, List<OrderEntity>>> getLateOrders() {
 return lateOrdersRemoteDataSource.getLateOrders();
  }

}