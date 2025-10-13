import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/use_cases/get_accepted_order_message_use_case/get_accepted_order_message_use_case.dart';
import 'get_accepted_order_message_states.dart';
enum UserRole { freelancer, client }
@injectable
class GetAcceptedOrderMessageViewModel
    extends Cubit<GetAcceptedOrderMessageStates> {
  GetAcceptedOrderMessageViewModel(this.getAcceptedOrderMessagesUseCase)
    : super(GetAcceptedOrderMessageStatesInitial());
  GetAcceptedOrderMessagesUseCase getAcceptedOrderMessagesUseCase;

  Future<Either<Failures, List<OrderEntity>>> getAcceptedOrderMessages(
    String userId,
      UserRole role
  ) async {
    try {
      emit(GetAcceptedOrderMessageStatesLoading());
      final result = await getAcceptedOrderMessagesUseCase(userId,role );
      result.fold(
        (failure) =>
            emit(GetAcceptedOrderMessageStatesError(message: failure.message)),
        (orders) => emit(GetAcceptedOrderMessageStatesSuccess(orders: orders)),
      );
      return result;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
