import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

class AdminPaymentsViewModelStates {}
class AdminPaymentsViewModelInitialState extends AdminPaymentsViewModelStates{}
class AdminPaymentsViewModelLoadingState extends AdminPaymentsViewModelStates{}
class AdminPaymentsViewModelSuccessState extends AdminPaymentsViewModelStates{
  final List<PaymentEntity> payments;
  AdminPaymentsViewModelSuccessState(this.payments);
}
class AdminPaymentsViewModelErrorState extends AdminPaymentsViewModelStates{
  final String message;
  AdminPaymentsViewModelErrorState(this.message);
}