import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/use_cases/update_payment_status_use_case/update_payment_status_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/update_payment_status_view_model/update_payment_status_view_model_states.dart';
@injectable
class UpdatePaymentStatusViewModel
    extends Cubit<UpdatePaymentStatusViewModelStates> {
  UpdatePaymentStatusViewModel(this.updatePaymentStatusUseCase)
    : super(UpdatePaymentStatusViewModelStatesInitial());
  UpdatePaymentStatusUseCase updatePaymentStatusUseCase;
  Future<void> updatePaymentStatus({
    required String paymentId,
    required String status,
    required String freelancerId,
    required double amount,
  }) async {
    try {
      emit(UpdatePaymentStatusViewModelStatesLoading());
      var result = await updatePaymentStatusUseCase.call(paymentId, status, freelancerId, amount);
      result.fold(
        (l) =>
            emit(UpdatePaymentStatusViewModelStatesError(message: l.message)),
        (r) => emit(
          UpdatePaymentStatusViewModelStatesSuccess(
            message: "Payment Status Updated",
          ),
        ),
      );
    } catch (e) {
      emit(UpdatePaymentStatusViewModelStatesError(message: e.toString()));
    }
  }
}
