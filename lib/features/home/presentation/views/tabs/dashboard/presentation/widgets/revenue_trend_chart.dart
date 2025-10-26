import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';

class RevenueTrendChart extends StatelessWidget {
  final List<RevenueStatisticsEntity> revenueStatistics;
  final String timeRange;

  const RevenueTrendChart({
    super.key,
    required this.revenueStatistics,
    this.timeRange = 'weekly',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (revenueStatistics.isEmpty) {
      return _buildEmptyState();
    }

    final barGroups = _generateBarGroups();
    final maxY = revenueStatistics
        .map((e) => e.totalRevenue.toDouble())
        .reduce((a, b) => a > b ? a : b);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey[900] : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme, isDark),
              SizedBox(height: 24.h),


              SizedBox(
                height: 300.h,

                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY + (maxY * 0.2),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= revenueStatistics.length) return const SizedBox();
                            final date = revenueStatistics[index].periodDate;
                            return Text(
                              "${date.day}/${date.month}",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 10.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    barGroups: barGroups,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final entity = revenueStatistics[group.x.toInt()];
                          return BarTooltipItem(
                            "${entity.totalRevenue.toStringAsFixed(0)} SAR\n${entity.periodDate.day}/${entity.periodDate.month}",
                            TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                        tooltipRoundedRadius: 8,
                        tooltipPadding: EdgeInsets.all(8.w),
                        tooltipMargin: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(revenueStatistics.length, (index) {
      final value = revenueStatistics[index].totalRevenue.toDouble();
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: ColorsManager.primary,
            width: 18.w,
            borderRadius: BorderRadius.circular(6.r),
            gradient: LinearGradient(
              colors: [
                ColorsManager.primary.withOpacity(0.9),
                ColorsManager.primary.withOpacity(0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildHeader(ThemeData theme, bool isDark) {
    final total = revenueStatistics.fold<double>(0, (sum, item) => sum + item.totalRevenue);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Revenue Overview",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.grey[800],
          ),
        ),
        Text(
          "${total.toStringAsFixed(0)} SAR",
          style: theme.textTheme.titleLarge?.copyWith(
            color: ColorsManager.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 250.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[50],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart_rounded, color: Colors.grey[300], size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            "No Revenue Data",
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
