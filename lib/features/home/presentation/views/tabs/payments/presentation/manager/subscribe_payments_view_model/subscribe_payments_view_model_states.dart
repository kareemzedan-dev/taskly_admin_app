import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

abstract class SubscribePaymentsViewModelStates {}

class SubscribePaymentsViewModelStatesInitial
    extends SubscribePaymentsViewModelStates {}

class SubscribePaymentsViewModelStatesLoading
    extends SubscribePaymentsViewModelStates {}

class SubscribePaymentsViewModelStatesError
    extends SubscribePaymentsViewModelStates {
  final String message;
  SubscribePaymentsViewModelStatesError(this.message);
}

class SubscribePaymentsViewModelStatesNewData
    extends SubscribePaymentsViewModelStates {
  final List<PaymentEntity> payments;
  SubscribePaymentsViewModelStatesNewData(this.payments);
}
