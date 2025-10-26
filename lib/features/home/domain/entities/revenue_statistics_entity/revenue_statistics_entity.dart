class RevenueStatisticsEntity {
  final DateTime periodDate;
  final String periodType;
  final double totalRevenue;
  final int totalOrders;
  final DateTime updatedAt;

  RevenueStatisticsEntity({
    required this.periodDate,
    required this.periodType,
    required this.totalRevenue,
    required this.totalOrders,
    required this.updatedAt,
  });
}
