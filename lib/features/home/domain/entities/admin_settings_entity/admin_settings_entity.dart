class AdminSettingsEntity {
  final String id;
  final String adminId;
  final double commission;    
  final DateTime createdAt;
  final DateTime updatedAt;

  AdminSettingsEntity({
    required this.id,
    required this.adminId,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
  });
}
