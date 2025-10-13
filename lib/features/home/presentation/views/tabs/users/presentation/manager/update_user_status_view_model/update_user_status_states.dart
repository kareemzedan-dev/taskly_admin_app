abstract class UpdateUserStatusStates {}

class UpdateUserStatusStatesInitial extends UpdateUserStatusStates {}

class UpdateUserStatusStatesLoading extends UpdateUserStatusStates {}

class UpdateUserStatusStatesSuccess extends UpdateUserStatusStates {
  final bool? isVerified;
  final String? status;

  UpdateUserStatusStatesSuccess({this.isVerified, this.status});
}

class UpdateUserStatusStatesError extends UpdateUserStatusStates {
  final String message;
  UpdateUserStatusStatesError({required this.message});
}
