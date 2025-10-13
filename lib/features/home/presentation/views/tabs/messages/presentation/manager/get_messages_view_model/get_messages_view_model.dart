import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/entities/message_entity/message_entity.dart';
import '../../../../../../../domain/use_cases/get_order_messages_use_case/get_order_messages_use_case.dart';
import 'get_messages_view_model_states.dart';

@injectable
class GetMessagesViewModel extends Cubit<GetMessagesViewModelStates> {
  final GetOrderMessagesUseCase getMessagesUseCase;

  GetMessagesViewModel(this.getMessagesUseCase) : super(GetMessagesViewModelStatesInitial());

  StreamSubscription<List<MessageEntity>>? _messagesStreamSubscription;
  List<MessageEntity> _currentMessages = [];

  Future<void> getMessages({required String senderId, required String receiverId}) async {
    try {
      if (isClosed) return;
      emit(GetMessagesViewModelStatesLoading());

      final result = await getMessagesUseCase.call(senderId: senderId, receiverId: receiverId);

      if (isClosed) return;
      result.fold(
            (failure) => emit(GetMessagesViewModelStatesError(failure: failure)),
            (messages) {
          _currentMessages = List.from(messages)..sort((a, b) => a.createdAt.compareTo(b.createdAt));
          emit(GetMessagesViewModelStatesSuccess(messages: _currentMessages));
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(GetMessagesViewModelStatesError(failure: ServerFailure(e.toString())));
      }
    }
  }


  void subscribeToMessagesStream({required String senderId, required String receiverId}) {
    // إلغاء أي اشتراك سابق
    _messagesStreamSubscription?.cancel();

    _messagesStreamSubscription = getMessagesUseCase
        .callSubscribe(senderId: senderId, receiverId: receiverId)
        .listen(
          (messages) {
        scheduleMicrotask(() {
          if (!isClosed) {
            _currentMessages = messages..sort((a, b) => a.createdAt.compareTo(b.createdAt));
            emit(GetMessagesViewModelStatesSuccess(messages: List.from(_currentMessages)));
          }
        });
      },

      onError: (error) {
        if (!isClosed) {
          scheduleMicrotask(() {
            if (!isClosed) {
              emit(GetMessagesViewModelStatesError(failure: ServerFailure(error.toString())));
            }
          });
        }
      },

    );
  }

  void unsubscribe() {
    _messagesStreamSubscription?.cancel();
    _messagesStreamSubscription = null;
  }

  @override
  Future<void> close() {
    unsubscribe();
    return super.close();
  }
}
