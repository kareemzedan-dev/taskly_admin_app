import '../../../../../../../domain/entities/offer_entity/offer_entity.dart';

class SubscribeToOffersStates {}
class SubscribeToOffersStatesInitial extends SubscribeToOffersStates {}

class SubscribeToOffersStatesLoading extends SubscribeToOffersStates {}

class SubscribeToOffersStatesSuccess extends SubscribeToOffersStates {
  final List<OfferEntity> offers;
  SubscribeToOffersStatesSuccess(this.offers);
}

class SubscribeToOffersStatesError extends SubscribeToOffersStates {
  final String message;
  SubscribeToOffersStatesError(this.message);
}