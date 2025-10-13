import '../../../../../../../domain/entities/order_entity/order_entity.dart';

class GetAllOrdersStates {}

class GetAllOrdersInitial extends GetAllOrdersStates {}

class GetAllOrdersLoadingState extends GetAllOrdersStates {}

class GetAllOrdersSuccessState extends GetAllOrdersStates {
  final List<OrderEntity> orders;
  final int totalOrders;
  final double totalEarnings;

  GetAllOrdersSuccessState({
    required this.orders,
    required this.totalOrders,
    required this.totalEarnings,
  });
}

class GetAllOrdersErrorState extends GetAllOrdersStates {
  final String message;
  GetAllOrdersErrorState(this.message);
}
