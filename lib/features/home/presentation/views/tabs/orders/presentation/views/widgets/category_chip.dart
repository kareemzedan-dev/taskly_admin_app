

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip(this.category, {super.key});
  final String category;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: ColorsManager.primary.withOpacity(.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            category,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
