import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

class OrderVolumeChart extends StatelessWidget {
  final List<OrderEntity> orders;

  const OrderVolumeChart({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {

    final Map<int, int> weeklyOrders = {};
    for (var order in orders) {
      if (order.status.name.toLowerCase() == "completed") {
        final weekday = order.createdAt.weekday; // 1=Mon .. 7=Sun
        weeklyOrders[weekday] = (weeklyOrders[weekday] ?? 0) + 1;
      }
    }


    final barGroups = List.generate(
      7,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: (weeklyOrders[i + 1] ?? 0).toDouble(),
            gradient: LinearGradient(
              colors: [Colors.blue[400]!, Colors.blue[600]!],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            width: 16.w,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (weeklyOrders.values.isNotEmpty
                ? weeklyOrders.values.reduce((a, b) => a > b ? a : b)
                : 10)
            .toDouble() + 2,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey[300], strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                const texts = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                if (value < 0 || value > 6) return const SizedBox();
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    texts[value.toInt()],
                    style: TextStyle(color: Colors.grey[700], fontSize: 10.sp),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
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
        barGroups: barGroups,
      ),
    );
  }
}
