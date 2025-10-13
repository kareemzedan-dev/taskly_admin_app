import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/domain/use_cases/add_bank_account_use_case/add_bank_account_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/add_bank_acount_view_model/add_bank_acount_view_model_states.dart';
import 'package:injectable/injectable.dart';

  @injectable
class AddBankAccountViewModel extends Cubit<AddBankAccountStates> {
  final AddBankAccountUseCase addBankAccountUseCase;

  AddBankAccountViewModel(this.addBankAccountUseCase)
      : super(AddBankAccountInitial());

  Future<void> addAccount(bankAccountEntity) async {
    emit(AddBankAccountLoading());

    final result = await addBankAccountUseCase.call(bankAccountEntity);

    result.fold(
      (failure) => emit(AddBankAccountError(failure.message)),
      (_) => emit(AddBankAccountSuccess()),
    );
  }
}
