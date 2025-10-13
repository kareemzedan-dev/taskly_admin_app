abstract class UpdateBankAccountStatusStates {}

class UpdateBankAccountStatusInitial extends UpdateBankAccountStatusStates {}

class UpdateBankAccountStatusLoading extends UpdateBankAccountStatusStates {
  final String id;
  UpdateBankAccountStatusLoading(this.id);
}

class UpdateBankAccountStatusSuccess extends UpdateBankAccountStatusStates {
  final String id;
  UpdateBankAccountStatusSuccess(this.id);
}

class UpdateBankAccountStatusError extends UpdateBankAccountStatusStates {
  final String id;
  final String message;
  UpdateBankAccountStatusError(this.id, this.message);
}
