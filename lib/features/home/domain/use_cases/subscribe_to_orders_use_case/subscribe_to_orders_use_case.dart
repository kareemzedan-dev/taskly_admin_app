import 'package:injectable/injectable.dart';

import '../../entities/order_entity/order_entity.dart';
import '../../repos/orders/orders_repos.dart';

@injectable
class SubscribeToOrdersUseCase {
  OrdersRepos ordersRepos;
  SubscribeToOrdersUseCase(this.ordersRepos);
  Stream<List<OrderEntity>> callOrdersRealtime() {


    return   ordersRepos.orderRealtimeRepository();
  }

}