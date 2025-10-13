import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';
import 'package:taskly_admin/features/home/domain/use_cases/add_commission_use_case/add_commission_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/add_commission_view_model/add_commission_states.dart';
@injectable
class AddCommissionViewModel extends Cubit<AddCommissionStates>{
  AddCommissionViewModel(this.addCommissionUseCase) : super(AddCommissionInitState());
  AddCommissionUseCase addCommissionUseCase  ;

  Future<void> addCommission(AdminSettingsEntity commission)async{
 try {
      emit(AddCommissionLoadingState());
    final result = await addCommissionUseCase.call(commission);
    result.fold((l) => emit(AddCommissionErrorState(l.message)),
     (r) => emit(AddCommissionSuccessState(r)));

 }
 catch(e){
   emit(AddCommissionErrorState(e.toString()));
 }
  }
}