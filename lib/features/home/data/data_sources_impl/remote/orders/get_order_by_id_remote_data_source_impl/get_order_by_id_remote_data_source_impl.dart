import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/cache/app_cache_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../data_sources/remote/orders/get_all_orders_remote_data_source/get_all_orders_remote_data_source.dart';
import '../../../../data_sources/remote/orders/get_order_by_id_remote_data_source/get_order_by_id_remote_data_source.dart';
import '../../../../models/order_model/order_model.dart';
@Injectable(as: GetOrderByIdRemoteDataSource)
class GetOrderByIdRemoteDataSourceImpl extends GetOrderByIdRemoteDataSource {
  final SupabaseService supabaseService;

  GetOrderByIdRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<OrderEntity>>> getOrdersByUser(
      String userId,
      String role,
   ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure('No internet connection'));
      }


      final column = role == "client" ? "client_id" : "freelancer_id";

      final result = await supabaseService.getAll(
        table: 'orders',
        filters: {column: userId},
        orderBy: 'created_at',
        ascending: false,
      );

      if (result.isEmpty) {
        return Left(ServerFailure('No orders found for this $role'));
      }

      final orders = result.map((e) => OrderDm.fromJson(e).toEntity()).toList();
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch orders: $e'));
    }
  }
}
