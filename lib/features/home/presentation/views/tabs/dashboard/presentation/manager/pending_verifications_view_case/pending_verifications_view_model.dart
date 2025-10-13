import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/pending_verifications_view_case/pending_verifications_states.dart';

import '../../../../../../../domain/use_cases/get_pending_verifications_use_case/get_pending_verifications_use_case.dart';
@injectable
class PendingVerificationsViewModel extends Cubit<PendingVerificationsStates> {
  final GetPendingVerificationsUseCase getPendingVerificationsUseCase;

  PendingVerificationsViewModel(this.getPendingVerificationsUseCase)
    : super(PendingVerificationsStatesInitial());

  Future<void> getPendingVerifications() async {
    try {
      emit(PendingVerificationsStatesLoading());
      final pendingVerifications = await getPendingVerificationsUseCase.call();
      pendingVerifications.fold(
        (failure) =>
            emit(PendingVerificationsStatesError(message: failure.message)),
        (pendingVerifications) => emit(
          PendingVerificationsStatesSuccess(users: pendingVerifications),
        ),
      );
    } catch (e) {
      emit(PendingVerificationsStatesError(message: e.toString()));
    }
  }
}
