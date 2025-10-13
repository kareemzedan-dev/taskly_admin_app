import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

class GetConversationsStates {}

class GetConversationsInitialStates extends GetConversationsStates {}

class GetConversationsLoadingStates extends GetConversationsStates {}

class GetConversationsSuccessStates extends GetConversationsStates {
  List<UserEntity> conversationsList;
  GetConversationsSuccessStates({required this.conversationsList});
}

class GetConversationsErrorStates extends GetConversationsStates {
  String errorMessage;
  GetConversationsErrorStates({required this.errorMessage});
}