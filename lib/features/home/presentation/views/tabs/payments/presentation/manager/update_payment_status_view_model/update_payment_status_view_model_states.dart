class UpdatePaymentStatusViewModelStates {}

class UpdatePaymentStatusViewModelStatesInitial extends UpdatePaymentStatusViewModelStates {}

class UpdatePaymentStatusViewModelStatesLoading extends UpdatePaymentStatusViewModelStates {}

class UpdatePaymentStatusViewModelStatesSuccess extends UpdatePaymentStatusViewModelStates {
  final String message;
  UpdatePaymentStatusViewModelStatesSuccess({required this.message});
}

class UpdatePaymentStatusViewModelStatesError extends UpdatePaymentStatusViewModelStates {
  final String message;
  UpdatePaymentStatusViewModelStatesError({required this.message});
}
