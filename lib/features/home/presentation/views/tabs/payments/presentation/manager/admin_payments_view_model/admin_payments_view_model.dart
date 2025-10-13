import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_all_payments_use_case/get_all_payments_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/admin_payments_view_model/admin_payments_view_model_states.dart';
@injectable
class AdminPaymentsViewModel extends Cubit<AdminPaymentsViewModelStates> {
  AdminPaymentsViewModel(this.getAllPaymentsUseCase)
    : super(AdminPaymentsViewModelInitialState());

  GetAllPaymentsUseCase getAllPaymentsUseCase;

  Future<Either<Failures, List<PaymentEntity>>> getAllPayments( ) async {
    try {
      emit(AdminPaymentsViewModelLoadingState());
      final Either<Failures, List<PaymentEntity>> result =
          await getAllPaymentsUseCase.call();
      result.fold(
        (l) => emit(AdminPaymentsViewModelErrorState(l.message)),
        (r) => emit(AdminPaymentsViewModelSuccessState(r)),
      );
      return result;
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }
}
