import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/models/order_model/order_model.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/orders/subscribe_to_orders_remote_data_source/subscribe_to_orders_remote_data_source.dart';
@Injectable(as: SubscribeToOrdersRemoteDataSource)
class SubscribeToOrdersRemoteDataSourceImpl
    extends SubscribeToOrdersRemoteDataSource {
  final SupabaseService supabaseService;

  SubscribeToOrdersRemoteDataSourceImpl(this.supabaseService);

  @override
  Stream<List<OrderEntity>> orderRealtimeRepository() {
    if (NetworkUtils.hasInternet() == false) {
      // نرمي exception بدل ما نعمل return stream فاضي
      throw NetworkFailure('No internet connection');
    }

    return supabaseService.subscribeToTable(table: "orders").map(
          (events) {
        return events.map((e) => OrderDm.fromJson(e)).toList();
      },
    );
  }
}
