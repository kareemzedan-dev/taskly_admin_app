import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

class UserPaymentsViewModelStates {
 
}
class UserPaymentsViewModelStatesInitial extends UserPaymentsViewModelStates {}
class UserPaymentsViewModelStatesLoading extends UserPaymentsViewModelStates {}
class UserPaymentsViewModelStatesSuccess extends UserPaymentsViewModelStates {
    final List<PaymentEntity> payments;
    UserPaymentsViewModelStatesSuccess({required this.payments});

}
class UserPaymentsViewModelStatesError extends UserPaymentsViewModelStates {
  final String message;
  UserPaymentsViewModelStatesError({required this.message});
}