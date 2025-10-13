import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';

class AddCommissionStates {}

class AddCommissionSuccessState extends AddCommissionStates {
  final AdminSettingsEntity adminSettings;
  AddCommissionSuccessState(this.adminSettings);
}

class AddCommissionErrorState extends AddCommissionStates {
  final String message;
  AddCommissionErrorState(this.message);
}

class AddCommissionLoadingState extends AddCommissionStates {
   
}

class AddCommissionInitState extends AddCommissionStates {}