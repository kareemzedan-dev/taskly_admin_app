import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_orders_conversions_use_case/get_orders_conversions_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_orders_conversions_view_model/get_orders_conversions_states.dart';
@injectable
class GetOrdersConversionsViewModel extends Cubit<GetOrdersConversionsStates>{
  GetOrdersConversionsViewModel(this.getOrdersConversionsUseCase) : super(GetOrdersConversionsStatesInitial());
  GetOrdersConversionsUseCase getOrdersConversionsUseCase;
  Future<void> getOrdersConversions()async{
   try{
      emit(GetOrdersConversionsStatesLoading());
    final res = await getOrdersConversionsUseCase.call();
    res.fold((l) => emit(GetOrdersConversionsStatesError(l.message)), (r) => emit(GetOrdersConversionsStatesSuccess(r)));
  
   }
   catch(e){
    emit(GetOrdersConversionsStatesError(e.toString()));
   }
  
  }
}