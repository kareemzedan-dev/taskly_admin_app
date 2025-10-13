import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class PriceDurationSection extends StatelessWidget {
  final String price;
  final String duration;
  final String status;

  const PriceDurationSection({
    super.key,
    required this.price,
    required this.duration,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(status, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorsManager.primary,
            fontSize: 16.sp,
          )),
        ),
        SizedBox(height: 5.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: ColorsManager.primary, width: 1.w),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                price,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: ColorsManager.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(duration, style: Theme.of(context).textTheme.bodyLarge),

      ],
    );
  }
}
