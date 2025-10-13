import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/domain/use_cases/delete_bank_account_use_case/delete_bank_account_use_case.dart';
import 'delete_bank_account_states.dart';
import 'package:injectable/injectable.dart';

  @injectable
class DeleteBankAccountViewModel extends Cubit<DeleteBankAccountStates> {
  final DeleteBankAccountUseCase deleteBankAccountUseCase;

  DeleteBankAccountViewModel(this.deleteBankAccountUseCase)
      : super(DeleteBankAccountInitial());

  Future<void> deleteAccount(String id) async {
    emit(DeleteBankAccountLoading());

    final result = await deleteBankAccountUseCase.call(id);

    result.fold(
      (failure) => emit(DeleteBankAccountError(failure.message)),
      (_) => emit(DeleteBankAccountSuccess()),
    );
  }
}
