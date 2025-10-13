import '../../../../../../../domain/entities/user_entity/user_entity.dart';

class GetAllUsersStates {}
class GetAllUsersInitial extends GetAllUsersStates {}
class GetAllUsersLoadingState extends GetAllUsersStates {}
class GetAllUsersSuccessState extends GetAllUsersStates {
  final List<UserEntity> users;
  final int clientsCount;
  final int freelancersCount;

  GetAllUsersSuccessState({
    required this.users,
    required this.clientsCount,
    required this.freelancersCount,
  });
}

class GetAllUsersErrorState extends GetAllUsersStates {
  final String message;
  GetAllUsersErrorState(this.message);

}