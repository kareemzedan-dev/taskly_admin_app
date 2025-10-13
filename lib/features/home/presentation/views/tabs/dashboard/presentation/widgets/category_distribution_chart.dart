import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../domain/entities/category_distribution_entity/category_distribution_entity.dart';
import 'category_color_manager.dart';
import 'legend_item.dart';

class CategoryDistributionWithLegend extends StatelessWidget {
  final List<CategoryDistributionEntity> data;
  final CategoryColorManager colorManager = CategoryColorManager();

  CategoryDistributionWithLegend({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150.h,
          width: 150.w,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 30,
              sections: data.map((cat) {
                final color = colorManager.getColorForCategory(cat.categoryName);
                return PieChartSectionData(
                  value: cat.percentage,
                  color: color,
                  radius: 50,
                  title: "${cat.percentage.toStringAsFixed(1)}%",
                  titleStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.w,
              runSpacing: 4.h,
              children: data.map((cat) {
                final color = colorManager.getColorForCategory(cat.categoryName);
                return LegendItem(
                  color: color,
                  text: cat.categoryName,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
