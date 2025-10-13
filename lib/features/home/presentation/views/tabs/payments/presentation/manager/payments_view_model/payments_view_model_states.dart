 
 
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

abstract class PaymentsViewModelStates {}

class PaymentsInitialState extends PaymentsViewModelStates {}

class PaymentsLoadingState extends PaymentsViewModelStates {}

class PaymentsSuccessState extends PaymentsViewModelStates {
  final List<PaymentEntity> payments;
  PaymentsSuccessState(this.payments);
}

class PaymentsErrorState extends PaymentsViewModelStates {
  final String message;
  PaymentsErrorState(this.message);
}
