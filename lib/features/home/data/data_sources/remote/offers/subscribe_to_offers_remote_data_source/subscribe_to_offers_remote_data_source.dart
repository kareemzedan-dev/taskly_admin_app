
import '../../../../../domain/entities/offer_entity/offer_entity.dart';

abstract class SubscribeToOffersRemoteDataSource {
  Stream<List<OfferEntity>> offerRealtimeRepository(String orderId) ;
}