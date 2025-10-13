import '../../../../../../../domain/entities/order_entity/order_entity.dart';

class SubscribeToOrdersStates {}
class SubscribeToOrdersStatesInitial extends SubscribeToOrdersStates {}
class SubscribeToOrdersStatesLoading extends SubscribeToOrdersStates {}
class SubscribeToOrdersStatesSuccess extends SubscribeToOrdersStates {
  final List<OrderEntity> orders;
  final int newCount;
  final int progressCount;
  final int deliveredCount;
  final int cancelledCount;

  SubscribeToOrdersStatesSuccess({
    required this.orders,
    required this.newCount,
    required this.progressCount,
    required this.deliveredCount,
    required this.cancelledCount,
  });
}

class SubscribeToOrdersStatesError extends SubscribeToOrdersStates {
  String message;
  SubscribeToOrdersStatesError(this.message);
}