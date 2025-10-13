class DeleteBankAccountStates {}

class DeleteBankAccountInitial extends DeleteBankAccountStates {}

class DeleteBankAccountLoading extends DeleteBankAccountStates {}

class DeleteBankAccountSuccess extends DeleteBankAccountStates {}

class DeleteBankAccountError extends DeleteBankAccountStates {
  final String message;
  DeleteBankAccountError(this.message);
}
