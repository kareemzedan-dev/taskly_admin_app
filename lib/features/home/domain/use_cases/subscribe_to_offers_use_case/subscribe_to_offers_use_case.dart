import 'package:injectable/injectable.dart';

import '../../entities/offer_entity/offer_entity.dart';
import '../../repos/orders/orders_repos.dart';

@injectable
class SubscribeToOffersUseCase {
  final OrdersRepos ordersRepos;
  SubscribeToOffersUseCase(this.ordersRepos);
  Stream<List<OfferEntity>> call(String orderId) {
    return ordersRepos.offerRealtimeRepository(orderId );
  }
}