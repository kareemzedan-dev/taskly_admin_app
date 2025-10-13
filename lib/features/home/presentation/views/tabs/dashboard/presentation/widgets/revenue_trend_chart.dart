import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../core/helper/revenue_helper.dart';

class RevenueTrendChart extends StatelessWidget {
  final List<PaymentEntity> payments;

  const RevenueTrendChart({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {

    final (spots, maxY) = RevenueHelper.calculateWeeklyRevenue(payments);

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey[300], strokeWidth: 1),
          getDrawingVerticalLine: (value) =>
              FlLine(color: Colors.grey[300], strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const texts = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value < 0 || value > 6) return const SizedBox();
                return Text(
                  texts[value.toInt()],
                  style: TextStyle(color: Colors.grey[700], fontSize: 10.sp),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '\$${value.toInt()}00',
                  style: TextStyle(color: Colors.grey[700], fontSize: 10.sp),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: ColorsManager.primary,
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              color: ColorsManager.primary.withOpacity(0.2),
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: ColorsManager.primary,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
