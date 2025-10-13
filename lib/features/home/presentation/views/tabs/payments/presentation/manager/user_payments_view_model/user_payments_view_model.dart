import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_user_payments_use_case/get_user_payments_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/user_payments_view_model/user_payments_view_model_states.dart';
@injectable
class UserPaymentsViewModel extends Cubit<UserPaymentsViewModelStates>{
  UserPaymentsViewModel(this.getPaymentsUseCase):super(UserPaymentsViewModelStatesInitial());
  GetUserPaymentsUseCase getPaymentsUseCase;

  Future< Either<Failures,List<PaymentEntity>>> getUserPayments({required String userId,required String role})async{
 try{
      emit(UserPaymentsViewModelStatesLoading());
    var result=await getPaymentsUseCase.call(userId: userId, role: role);
    result.fold((l) => emit(UserPaymentsViewModelStatesError(message: l.message)), 
    (r) => emit(UserPaymentsViewModelStatesSuccess(payments: r)));
 
  return result;
 }
 catch(e){
   emit(UserPaymentsViewModelStatesError(message: e.toString()));
   return Left(Failures(e.toString()));
 }
  }}