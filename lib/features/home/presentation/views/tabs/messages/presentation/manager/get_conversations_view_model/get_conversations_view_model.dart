import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_conversations_use_case/get_conversations_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_conversations_view_model/get_conversations_states.dart';

@injectable
class GetConversationsViewModel extends Cubit<GetConversationsStates> {
  final GetConversationsUseCase getConversationsUseCase;

  GetConversationsViewModel(this.getConversationsUseCase)
      : super(GetConversationsInitialStates());

  Stream<List<UserEntity>>? _subscription;

  Future<Either<Failures, List<UserEntity>>> getConversations(String adminId) async {
    try {
      emit(GetConversationsLoadingStates());

      // أول مرة نجيب الداتا
      final result = await getConversationsUseCase.call(adminId);
      result.fold(
            (failure) {
          print("Error fetching conversations: ${failure.message}");
          if (!isClosed) emit(GetConversationsErrorStates(errorMessage: failure.message));
        },
            (conversations) {
          if (!isClosed) emit(GetConversationsSuccessStates(conversationsList: conversations));
        },
      );

      // نبدأ نسمع للتحديثات الجديدة
      _subscription = getConversationsUseCase.subscribeToConversations(adminId);

      _subscription!.listen(
            (conversations) {
          if (!isClosed) {
            emit(GetConversationsSuccessStates(conversationsList: conversations));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(GetConversationsErrorStates(errorMessage: error.toString()));
          }
        },
      );

      return result;
    } catch (e) {
      if (!isClosed) emit(GetConversationsErrorStates(errorMessage: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    // نلغي الـ Stream لما البلوك يتقفل عشان مايحصلش memory leak
    _subscription = null;
    return super.close();
  }
}
