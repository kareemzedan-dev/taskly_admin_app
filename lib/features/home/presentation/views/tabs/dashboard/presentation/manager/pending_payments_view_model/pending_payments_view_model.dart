
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/pending_payments_view_model/pending_payments_states.dart';

import '../../../../../../../domain/use_cases/get_pending_payments_use_case/get_pending_payments_use_case.dart';
@injectable
class PendingPaymentsViewModel extends Cubit<PendingPaymentsStates> {
  final GetPendingPaymentsUseCase getPendingPaymentsUseCase;
   PendingPaymentsViewModel(this.getPendingPaymentsUseCase) : super(PendingPaymentsStatesInitial());
   Future<void> getPendingPayments() async {
     try{
       emit(PendingPaymentsStatesLoading());
       final pendingPayments = await getPendingPaymentsUseCase.call();
       pendingPayments.fold(
         (failure) => emit(PendingPaymentsStatesError(message: failure.message)),
           (pendingPayments) => emit(PendingPaymentsStatesSuccess(pendingPayments: pendingPayments))
           );

     }
     catch(e){
       emit(PendingPaymentsStatesError(message: e.toString()));
     }
   }
}