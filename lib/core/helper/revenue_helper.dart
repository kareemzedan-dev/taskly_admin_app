import 'package:fl_chart/fl_chart.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';


class RevenueHelper {
  static (List<FlSpot>, double) calculateWeeklyRevenue(List<PaymentEntity> payments) {
    final Map<int, double> weeklyRevenue = {};

    for (var payment in payments) {
      if (payment.requesterType?.toLowerCase() == 'client' &&
          payment.status.toLowerCase() == 'approved') {
        final weekday = payment.createdAt.weekday;
        weeklyRevenue[weekday] =
            (weeklyRevenue[weekday] ?? 0) + payment.amount;
      }
    }

    final spots = List.generate(
      7,
          (i) => FlSpot(
        i.toDouble(),
        (weeklyRevenue[i + 1] ?? 0) / 100,
      ),
    );

    final maxY = (spots.isEmpty
        ? 0.0
        : spots.map((e) => e.y).reduce((a, b) => a > b ? a : b)) +
        1.0;

    return (spots, maxY);
  }
}
