import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

 

class ProfileViewModelStates {}

class ProfileViewModelStatesInitial extends ProfileViewModelStates {}

class ProfileViewModelStatesError extends ProfileViewModelStates {
  final String message;
  ProfileViewModelStatesError(this.message);
}

class ProfileViewModelStatesSuccess extends ProfileViewModelStates {
  final UserEntity userInfoEntity;

  ProfileViewModelStatesSuccess(this.userInfoEntity);
}

class ProfileViewModelStatesLoading extends ProfileViewModelStates {}