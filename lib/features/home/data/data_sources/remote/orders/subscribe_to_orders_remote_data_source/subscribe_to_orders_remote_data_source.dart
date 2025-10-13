

import '../../../../../domain/entities/order_entity/order_entity.dart';

abstract class SubscribeToOrdersRemoteDataSource {

  Stream<List<OrderEntity>> orderRealtimeRepository();
}