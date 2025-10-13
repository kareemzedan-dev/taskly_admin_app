

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repos/update_order_status_repo/update_order_status_repo.dart';
import '../../data_sources/remote/orders/update_order_status_remote_data_source/update_order_status_remote_data_source.dart';


@Injectable(as: UpdateOrderStatusRepo)
class UpdateOrderStatusRepoImpl implements UpdateOrderStatusRepo {
  final UpdateOrderStatusRemoteDataSource remoteDataSource;
  UpdateOrderStatusRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> updateOrderStatus(String orderId, String status) {
   return remoteDataSource.updateOrderStatus(orderId, status);
  }

}