import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';

class AdminSettingsModel extends AdminSettingsEntity {
  AdminSettingsModel({
    required String id,
    required String adminId,
    required double commission,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
         id: id,
         adminId: adminId,
         commission: commission,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory AdminSettingsModel.fromJson(Map<String, dynamic> json) {
    return AdminSettingsModel(
      id: json['id'] as String,
      adminId: json['admin_id'] as String,
      commission: (json['commission'] as num).toDouble(),
 
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin_id': adminId,
      'commission': commission,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
