import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/use_cases/subscribe_to_payments_use_case/subscribe_to_payments_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/subscribe_payments_view_model/subscribe_payments_view_model_states.dart';

@injectable
class SubscribePaymentsViewModel
    extends Cubit<SubscribePaymentsViewModelStates> {
  final SubscribePaymentsUseCase subscribePaymentsUseCase;

  List<PaymentEntity> _payments = [];

  SubscribePaymentsViewModel(this.subscribePaymentsUseCase)
      : super(SubscribePaymentsViewModelStatesInitial());

  void initPayments(List<PaymentEntity> payments) {
    _payments = payments;
    emit(SubscribePaymentsViewModelStatesNewData(List.from(_payments)));
  }

  void subscribeToPayments() {
    try {
      subscribePaymentsUseCase.call(
        onChange: (payment, action) {
          if (action == "INSERT") {
            _payments.add(payment);
          } else if (action == "UPDATE") {
            final index =
                _payments.indexWhere((p) => p.id == payment.id);
            if (index != -1) {
              _payments[index] = payment;
            }
          } else if (action == "DELETE") {
            _payments.removeWhere((p) => p.id == payment.id);
          }

          emit(SubscribePaymentsViewModelStatesNewData(List.from(_payments)));
        },
      );
    } catch (e) {
      emit(SubscribePaymentsViewModelStatesError(e.toString()));
    }
  }
}
