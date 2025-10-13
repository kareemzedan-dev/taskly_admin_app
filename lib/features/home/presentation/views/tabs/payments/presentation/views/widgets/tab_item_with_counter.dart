import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class TabItemWithCounter extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final Color iconColor  ;

  const TabItemWithCounter({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color:  iconColor),
        SizedBox(width: 6.w),
        Text(title),
        SizedBox(width: 6.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: ColorsManager.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
