import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_offers_view_model/subscribe_to_offers_states.dart';

import '../../../../../../../domain/use_cases/subscribe_to_offers_use_case/subscribe_to_offers_use_case.dart';

@injectable
class SubscribeToOffersViewModel extends Cubit<SubscribeToOffersStates> {
  final SubscribeToOffersUseCase subscribeToOffersUseCase;
  SubscribeToOffersViewModel(this.subscribeToOffersUseCase)
      : super(SubscribeToOffersStatesInitial());

  void getOffers(String orderId) {
    try {
      emit(SubscribeToOffersStatesLoading());

      final stream = subscribeToOffersUseCase(orderId);

      stream.listen(
            (offers) {
          emit(SubscribeToOffersStatesSuccess(offers));
        },
        onError: (error) {
          emit(SubscribeToOffersStatesError(error.toString()));
        },
      );
    } catch (e) {
      emit(SubscribeToOffersStatesError(e.toString()));
    }
  }

}
