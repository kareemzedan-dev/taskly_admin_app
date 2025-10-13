import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/use_cases/subscribe_to_orders_use_case/subscribe_to_orders_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_orders_view_model/subscribe_to_orders_states.dart';

import '../../../../../../../domain/entities/order_entity/order_entity.dart';
@injectable

class SubscribeToOrdersViewModel extends Cubit<SubscribeToOrdersStates> {
  final SubscribeToOrdersUseCase subscribeToOrdersUseCase;

  OrderFilter currentFilter = OrderFilter.all;

  SubscribeToOrdersViewModel(this.subscribeToOrdersUseCase)
      : super(SubscribeToOrdersStatesInitial());
StreamSubscription? _ordersSubscription;
List<OrderEntity> _lastOrders = [];

void getOrdersRealtime() {
  try {
    emit(SubscribeToOrdersStatesLoading());

    _ordersSubscription?.cancel();

    _ordersSubscription = subscribeToOrdersUseCase.callOrdersRealtime().listen(
      (orders) {
        _lastOrders = orders;
        _emitFilteredOrders();
      },
      onError: (error) {
        emit(SubscribeToOrdersStatesError(error.toString()));
      },
    );
  } catch (e) {
    emit(SubscribeToOrdersStatesError(e.toString()));
  }
}

void changeFilter(OrderFilter filter) {
  currentFilter = filter;
  _emitFilteredOrders();
}

void _emitFilteredOrders() {
  final filteredOrders = _applyFilter(_lastOrders);

  emit(
    SubscribeToOrdersStatesSuccess(
      orders: filteredOrders,
      newCount: filteredOrders.where((o) => o.status == OrderStatus.Pending).length,
      progressCount: filteredOrders.where((o) => o.status == OrderStatus.InProgress).length,
      deliveredCount: filteredOrders.where((o) => o.status == OrderStatus.Completed).length,
      cancelledCount: filteredOrders.where((o) => o.status == OrderStatus.Cancelled).length,
    ),
  );
}

  List<OrderEntity> _applyFilter(List<OrderEntity> orders) {
    switch (currentFilter) {
      case OrderFilter.all:
        return orders;
      case OrderFilter.delayed:
        return orders.where((o) {
          return o.deadline != null && o.deadline!.isBefore(DateTime.now()) && o.status != OrderStatus.Completed;
        }).toList();
    }
  }

  int getTimelineStep(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
      case OrderStatus.Accepted:
      case OrderStatus.Waiting:
      case OrderStatus.Paid:
        if (status == OrderStatus.Pending) return 0;
        if (status == OrderStatus.Accepted) return 1;
        if (status == OrderStatus.Waiting) return 2;
        if (status == OrderStatus.Paid) return 3;
        break;
      case OrderStatus.InProgress:
        return 2;
      case OrderStatus.Completed:
        return 1;
      case OrderStatus.Cancelled:
        return 1;
    }
    return 0;
  }
}

enum OrderFilter {
  all,
  delayed,
}
