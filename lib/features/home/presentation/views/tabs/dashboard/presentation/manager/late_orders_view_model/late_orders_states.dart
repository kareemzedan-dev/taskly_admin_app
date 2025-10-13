import '../../../../../../../domain/entities/order_entity/order_entity.dart';

class LateOrdersStates {}
class LateOrdersStatesInitial extends LateOrdersStates {}
class LateOrdersStatesLoading extends LateOrdersStates {}
class LateOrdersStatesSuccess extends LateOrdersStates {
  final List<OrderEntity> lateOrders;
   LateOrdersStatesSuccess({required this.lateOrders});
}
class LateOrdersStatesError extends LateOrdersStates {
  final String message;
   LateOrdersStatesError({required this.message});
}