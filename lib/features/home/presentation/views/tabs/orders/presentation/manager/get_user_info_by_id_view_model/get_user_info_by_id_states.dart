import '../../../../../../../domain/entities/user_entity/user_entity.dart';

class GetUserInfoByIdStates {}
class GetUserInfoByIdInitial extends GetUserInfoByIdStates {}
class GetUserInfoByIdLoading extends GetUserInfoByIdStates {}
class GetUserInfoByIdSuccess extends GetUserInfoByIdStates {
  final UserEntity userEntity;
  GetUserInfoByIdSuccess(this.userEntity);
}
class GetUserInfoByIdError extends GetUserInfoByIdStates {
  final String message;
  GetUserInfoByIdError(this.message);

}