import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../domain/use_cases/order_by_user_use_case/order_by_user_use_case.dart';
import 'get_order_by_id_states.dart';

@injectable
class GetOrdersByIdViewModel extends Cubit<GetOrderByIdStates> {
  final OrdersByUserUseCase getOrderByIdUseCase;

  GetOrdersByIdViewModel(this.getOrderByIdUseCase) : super(GetOrderByIdInitial());

  Future<Either<Failures, List<OrderEntity>>> getOrdersByUser(
      String id,
      String role,
      ) async {
    try {
      emit(GetOrderByIdLoadingState());

      final result = await getOrderByIdUseCase(id, role);

      result.fold(
            (failure) {
          emit(GetOrderByIdErrorState(failure.message));
        },
            (orders) {
          final stats = _calculateStats(orders);

          emit(GetOrderByIdSuccessState(
            orders: orders,
            totalOrders: stats['totalOrders'] as int,
            completedOrders: stats['completedOrders'] as int,
            totalEarnings: stats['totalEarnings'] as double,
          ));
        },
      );

      return result;
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }

  Map<String, dynamic> _calculateStats(List<OrderEntity> orders) {
    final totalOrders = orders.length;
    final completedOrders = orders.where((order) => order.status == OrderStatus.Completed).length;

    final totalEarnings = orders
        .where((order) => order.status == OrderStatus.Completed)
        .fold<double>(0.0, (sum, order) => sum + (order.budget ?? 0));

    return {
      "totalOrders": totalOrders,
      "completedOrders": completedOrders,
      "totalEarnings": totalEarnings,
    };
  }

}
