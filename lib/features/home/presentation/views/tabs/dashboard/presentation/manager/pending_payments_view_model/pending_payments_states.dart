import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';


class PendingPaymentsStates {}
class PendingPaymentsStatesInitial extends PendingPaymentsStates {}
class PendingPaymentsStatesLoading extends PendingPaymentsStates {}
class PendingPaymentsStatesSuccess extends PendingPaymentsStates {
  final List<PaymentEntity> pendingPayments;
  PendingPaymentsStatesSuccess({required this.pendingPayments});
}
class PendingPaymentsStatesError extends PendingPaymentsStates {
  final String message;
   PendingPaymentsStatesError({required this.message});
}