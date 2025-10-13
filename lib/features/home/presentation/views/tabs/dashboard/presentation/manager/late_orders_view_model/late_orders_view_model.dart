import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_late_orders_use_case/get_late_orders_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/late_orders_view_model/late_orders_states.dart';
@injectable
class LateOrdersViewModel extends Cubit<LateOrdersStates> {
  final GetLateOrdersUseCase getLateOrdersUseCase;
  LateOrdersViewModel(this.getLateOrdersUseCase) : super(LateOrdersStatesInitial());

  Future<void> getLateOrders() async {
    try{
      emit(LateOrdersStatesLoading());
      final lateOrders = await getLateOrdersUseCase.call();
      lateOrders.fold(
        (failure) => emit(LateOrdersStatesError(message: failure.message)),
      (orders) => emit(LateOrdersStatesSuccess(lateOrders: orders)) );

    }
    catch(e){
      emit(LateOrdersStatesError(message: e.toString()));
    }
  }
}