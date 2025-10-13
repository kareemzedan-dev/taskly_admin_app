import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/data/models/order_model/order_model.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

import '../../../../data_sources/remote/orders/get_orders_conversions_remote_data_source/get_orders_conversions_remote_data_source.dart';

@Injectable(as: GetOrdersConversionsRemoteDataSource)
class GetOrdersConversionsRemoteDataSourceImpl
    implements GetOrdersConversionsRemoteDataSource {
  final SupabaseService supabaseService;

  GetOrdersConversionsRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<OrderEntity>>> getOrdersConversations() async {
    try {
      final client = supabaseService.supabaseClient;

      final response = await client
          .from('messages')
          .select('order_id, orders(*)')
          .order('created_at', ascending: false);

      if (response == null || (response as List).isEmpty) {
        return Left(ServerFailure('No data found'));
      }

      final List<OrderEntity> orders = [];
      final seenOrderIds = <String>{};

      for (var row in response as List) {
        if (row['orders'] != null) {
          final order = OrderDm.fromJson(row['orders'] as Map<String, dynamic>);
          if (!seenOrderIds.contains(order.id)) {
            orders.add(order);
            seenOrderIds.add(order.id);
          }
        }
      }

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
