import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/domain/use_cases/update_bank_account_status_use_case/update_bank_account_status_use_case.dart';
import 'update_bank_account_status_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateBankAccountStatusViewModel extends Cubit<UpdateBankAccountStatusStates> {
  final UpdateBankAccountStatusUseCase updateBankAccountStatusUseCase;

  Map<String, bool> accountsStatus = {};

  UpdateBankAccountStatusViewModel(this.updateBankAccountStatusUseCase)
      : super(UpdateBankAccountStatusInitial());

  void setInitialStatus(String id, bool isActive) {
    accountsStatus[id] = isActive;
  }

  Future<void> updateStatus(String id) async {
    final currentStatus = accountsStatus[id] ?? false;

    emit(UpdateBankAccountStatusLoading(id));

    final result = await updateBankAccountStatusUseCase.call(id, !currentStatus); // نعكس الحالة

    result.fold(
          (failure) => emit(UpdateBankAccountStatusError(id, failure.message)),
          (_) {
        accountsStatus[id] = !currentStatus;
        emit(UpdateBankAccountStatusSuccess(id));
      },
    );
  }
}
