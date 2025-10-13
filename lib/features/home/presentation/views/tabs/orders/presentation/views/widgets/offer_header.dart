
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/offer_filter.dart';

class OffersHeader extends StatelessWidget {
  final String title;
  final int count;
  final List<String> filters;
  final String? selectedFilter;
  final Function(String) onFilterSelected; // 👈 هنا

  const OffersHeader({
    super.key,
    required this.title,
    required this.count,
    required this.filters,
    this.selectedFilter,
    required this.onFilterSelected, // 👈 هنا
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "$count",
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: OffersFilters(
                filters: filters,
                selectedFilter: selectedFilter,
                onFilterSelected: onFilterSelected, // 👈 تمرير الـ callback
              ),
            ),
          ],
        ),
      ),
    );
  }
}
