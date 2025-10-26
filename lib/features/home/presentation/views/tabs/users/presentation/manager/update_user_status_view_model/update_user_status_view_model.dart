import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/use_cases/update_user_status_use_case/update_user_status_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_states.dart';
import '../../../../../../../../../core/helper/notification_message_helper.dart';
import '../../../../../../../../../core/services/notification_service.dart';

@injectable
class UpdateUserStatusViewModel extends Cubit<UpdateUserStatusStates> {
  UpdateUserStatusViewModel(this.updateUserStatusUseCase)
      : super(UpdateUserStatusStatesInitial());

  final UpdateUserStatusUseCase updateUserStatusUseCase;

  Future<void> updateUserStatus(
      String userId, {
        String? status,
        bool? isVerified,
        required String role,
      }) async {
    try {
      emit(UpdateUserStatusStatesLoading());

      final result = await updateUserStatusUseCase.call(
        userId,
        status: status,
        isVerified: isVerified,
        role: role,
      );

      result.fold(
            (l) => emit(UpdateUserStatusStatesError(message: l.message)),
            (r) async {
          emit(UpdateUserStatusStatesSuccess(
            isVerified: isVerified,
            status: status,
          ));

          final message = NotificationMessageHelper.buildUserStatusNotification(
            role: role,
            status: status,
            isVerified: isVerified,
          );

          await NotificationService().sendNotification(
            receiverId: userId,
            title: message["title"]!,
            body: message["body"]!,
          );
        },
      );
    } catch (e) {
      emit(UpdateUserStatusStatesError(message: e.toString()));
    }
  }
}
