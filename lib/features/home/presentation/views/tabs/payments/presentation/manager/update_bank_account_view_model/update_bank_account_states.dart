class UpdateBankAccountStates {}

class UpdateBankAccountInitial extends UpdateBankAccountStates {}

class UpdateBankAccountLoading extends UpdateBankAccountStates {}

class UpdateBankAccountSuccess extends UpdateBankAccountStates {}

class UpdateBankAccountError extends UpdateBankAccountStates {
  final String message;
  UpdateBankAccountError(this.message);
}
