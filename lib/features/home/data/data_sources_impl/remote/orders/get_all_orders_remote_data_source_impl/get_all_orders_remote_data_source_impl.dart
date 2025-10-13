import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/cache/app_cache_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../data_sources/remote/orders/get_all_orders_remote_data_source/get_all_orders_remote_data_source.dart';
import '../../../../models/order_model/order_model.dart';

@Injectable(as: GetAllOrdersRemoteDataSource)
class GetAllOrdersRemoteDataSourceImpl extends GetAllOrdersRemoteDataSource {
  final SupabaseService supabaseService;

  GetAllOrdersRemoteDataSourceImpl(this.supabaseService);

  static const cacheKey = 'all_orders';

  @override
  Future<Either<Failures, List<OrderEntity>>> getAllOrders() async {
    try {



      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure('No internet connection'));
      }


      final response = await supabaseService.getAll(
        table: 'orders',
        orderBy: 'created_at',
        ascending: false,
      );

      final orders = response.map((json) => OrderDm.fromJson(json).toEntity()).toList();


      return Right(orders);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch orders: $e'));
    }
  }
}
