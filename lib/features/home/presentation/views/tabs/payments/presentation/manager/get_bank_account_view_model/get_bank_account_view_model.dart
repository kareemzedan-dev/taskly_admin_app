import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_bank_accounts_use_case/get_bank_accounts_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/get_bank_account_view_model/get_bank_account_view_model_states.dart';
import 'package:injectable/injectable.dart';

  @injectable
class GetBankAccountViewModel extends Cubit<GetBankAccountViewModelStates> {
  final GetBankAccountsUseCase getBankAccountsUseCase;

  GetBankAccountViewModel(this.getBankAccountsUseCase)
      : super(GetBankAccountViewModelStatesInitial());

  Future<void> fetchBankAccounts() async {
    emit(GetBankAccountViewModelStatesLoading());

    final result = await getBankAccountsUseCase.call();

    result.fold(
      (failure) =>
          emit(GetBankAccountViewModelStatesError(message: failure.message)),
      (accounts) =>
          emit(GetBankAccountViewModelStatesSuccess(bankAccounts: accounts)),
    );
  }
}
