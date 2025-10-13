import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'send_message_view_model_states.dart';
import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/entities/message_entity/message_entity.dart';
import '../../../../../../../domain/use_cases/send_message_use_case/send_message_use_case.dart';
@injectable
class SendMessageViewModel extends Cubit<SendMessageViewModelStates> {
  final SendMessageUseCase sendMessageUseCase;

  SendMessageViewModel(this.sendMessageUseCase)
      : super(SendMessageViewModelStatesInitial());

  final List<MessageEntity> _temporaryMessages = [];
  bool _isSending = false;

  List<MessageEntity> get temporaryMessages => _temporaryMessages;

  void addTemporaryMessage(MessageEntity message) {
    if (_isSending) return;

    print('📝 Adding temporary message: ${message.id} - ${message.content}');
    _temporaryMessages.add(message);
    emit(SendMessageViewModelStatesTemporary(messages: List.from(_temporaryMessages)));
  }

  void updateMessage(MessageEntity updatedMessage) {
    final index = _temporaryMessages.indexWhere((m) => m.id == updatedMessage.id);
    if (index != -1) {
      print('🔄 Updating message: ${updatedMessage.id} - status: ${updatedMessage.status}');
      _temporaryMessages[index] = updatedMessage;
      emit(SendMessageViewModelStatesTemporary(messages: List.from(_temporaryMessages)));
    }
  }

  void removeTemporaryMessage(String messageId) {
    print('🗑️ Removing temporary message: $messageId');
    _temporaryMessages.removeWhere((m) => m.id == messageId);
    emit(SendMessageViewModelStatesTemporary(messages: List.from(_temporaryMessages)));
  }

  Future<void> sendMessage(MessageEntity message, {String? orderId}) async {
    if (_isSending) {
      print('⏳ Already sending a message, skipping...');
      return;
    }

    try {
      _isSending = true;
      print('🚀 Starting to send message: ${message.id}');

      // Add temporary message first
      if (!_temporaryMessages.any((m) => m.id == message.id)) {
        addTemporaryMessage(message);
      }

      emit(SendMessageViewModelStatesLoading());
      print('📤 Calling sendMessageUseCase...');

      final result = await sendMessageUseCase.call(message, orderId: orderId);

      result.fold(
            (failure) {
          print('❌ Send message failed: ${failure.message}');
          removeTemporaryMessage(message.id);
          emit(SendMessageViewModelStatesError(failure: failure));
          _isSending = false;
        },
            (sentMessage) {
          print('✅ Send message successful: ${sentMessage.id}');
          updateMessage(sentMessage.copyWith(status: "sent"));
          emit(SendMessageViewModelStatesSuccess(message: sentMessage));
          _isSending = false;
        },
      );
    } catch (e, stackTrace) {
      print('💥 Send message exception: $e');
      print('Stack trace: $stackTrace');
      removeTemporaryMessage(message.id);
      emit(SendMessageViewModelStatesError(failure: ServerFailure(e.toString())));
      _isSending = false;
    }
  }

  void clearTemporaryMessages() {
    _temporaryMessages.clear();
    emit(SendMessageViewModelStatesInitial());
  }
}