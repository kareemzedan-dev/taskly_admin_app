
import '../../../domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';

class RevenueStatisticsModel extends RevenueStatisticsEntity {
  RevenueStatisticsModel({
    required super.periodDate,
    required super.periodType,
    required super.totalRevenue,
    required super.totalOrders,
    required super.updatedAt,
  });

  factory RevenueStatisticsModel.fromJson(Map<String, dynamic> json) {
    return RevenueStatisticsModel(
      periodDate: DateTime.parse(json['period_date']),
      periodType: json['period_type'],
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      totalOrders: json['total_orders'] ?? 0,
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period_date': periodDate.toIso8601String(),
      'period_type': periodType,
      'total_revenue': totalRevenue,
      'total_orders': totalOrders,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
