import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/domain/use_cases/update_bank_account_use_case/update_bank_account_use_case.dart';
import 'update_bank_account_states.dart';
import 'package:injectable/injectable.dart';

  @injectable
class UpdateBankAccountViewModel extends Cubit<UpdateBankAccountStates> {
  final UpdateBankAccountUseCase updateBankAccountUseCase;

  UpdateBankAccountViewModel(this.updateBankAccountUseCase)
      : super(UpdateBankAccountInitial());

  Future<void> updateAccount(bankAccountEntity) async {
    emit(UpdateBankAccountLoading());

    final result = await updateBankAccountUseCase.call(bankAccountEntity);

    result.fold(
      (failure) => emit(UpdateBankAccountError(failure.message)),
      (_) => emit(UpdateBankAccountSuccess()),
    );
  }
}
