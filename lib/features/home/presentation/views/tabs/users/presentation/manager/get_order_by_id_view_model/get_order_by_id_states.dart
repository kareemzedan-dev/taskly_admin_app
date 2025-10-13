import '../../../../../../../domain/entities/order_entity/order_entity.dart';

abstract class GetOrderByIdStates {}

class GetOrderByIdInitial extends GetOrderByIdStates {}

class GetOrderByIdLoadingState extends GetOrderByIdStates {}

class GetOrderByIdErrorState extends GetOrderByIdStates {
  final String message;
  GetOrderByIdErrorState(this.message);
}

class GetOrderByIdSuccessState extends GetOrderByIdStates {
  final List<OrderEntity> orders;
  final int totalOrders;
  final int completedOrders;
  final double totalEarnings;

  GetOrderByIdSuccessState({
    required this.orders,
    required this.totalOrders,
    required this.completedOrders,
    required this.totalEarnings,
  });
}
