class AddBankAccountStates {}

class AddBankAccountInitial extends AddBankAccountStates {}

class AddBankAccountLoading extends AddBankAccountStates {}

class AddBankAccountSuccess extends AddBankAccountStates {}

class AddBankAccountError extends AddBankAccountStates {
  final String message;
  AddBankAccountError(this.message);
}
