
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatusAndTime extends StatelessWidget {
  final String status;
  final Color statusColor;
   final String time;

  const UserStatusAndTime({
    super.key,
    required this.status,
    required this.statusColor,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            status,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
          ),
        ),
        SizedBox(height: 4.h),

        Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: statusColor,
            fontSize: 12.sp,
              ),
        ),

      ],
    );
  }
}
