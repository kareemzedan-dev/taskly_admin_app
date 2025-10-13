import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/profile/presentation/manager/profile_view_model/profile_view_model_states.dart';

import '../../../domain/use_cases/profile/profile_use_case.dart';
 @injectable
class ProfileViewModel extends Cubit<ProfileViewModelStates>{
  ProfileViewModel(this.profileUseCase):super(ProfileViewModelStatesInitial());
  ProfileUseCase profileUseCase;

Future<void> getUserInfo(String userId ) async {
  try {
    if (isClosed) return;
    emit(ProfileViewModelStatesLoading());

    final result = await profileUseCase.callUserInfo(userId );

    if (isClosed) return;
    result.fold(
      (l) => emit(ProfileViewModelStatesError(l.message)),
      (r) => emit(ProfileViewModelStatesSuccess(r)),
    );
  } catch (e) {
    if (isClosed) return;
    emit(ProfileViewModelStatesError(e.toString()));
  }
}

}