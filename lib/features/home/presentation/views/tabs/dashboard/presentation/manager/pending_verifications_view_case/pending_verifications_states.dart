import '../../../../../../../domain/entities/user_entity/user_entity.dart';

class PendingVerificationsStates {}
class PendingVerificationsStatesInitial extends PendingVerificationsStates {}
class PendingVerificationsStatesLoading extends PendingVerificationsStates {}
class PendingVerificationsStatesSuccess extends PendingVerificationsStates {
  final List<UserEntity> users;
  PendingVerificationsStatesSuccess({required this.users});

}
class PendingVerificationsStatesError extends PendingVerificationsStates {
  final String message;
  PendingVerificationsStatesError({required this.message});
}