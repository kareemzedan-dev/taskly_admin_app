import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

class GetOrdersConversionsStates {}

class GetOrdersConversionsStatesSuccess extends GetOrdersConversionsStates {
  final List<OrderEntity> ordersConversionsList;
  GetOrdersConversionsStatesSuccess(this.ordersConversionsList);
}

class GetOrdersConversionsStatesError extends GetOrdersConversionsStates {
  final String message;
  GetOrdersConversionsStatesError(this.message);
}

class GetOrdersConversionsStatesLoading extends GetOrdersConversionsStates {}

class GetOrdersConversionsStatesInitial extends GetOrdersConversionsStates {}
