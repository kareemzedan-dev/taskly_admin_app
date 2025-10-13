import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';
class AdminMessageCard extends StatelessWidget {
  const AdminMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            FontAwesomeIcons.circleExclamation,
            color: ColorsManager.black,
            size: 14.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order created successfully, payment is pending admin approval.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '9.00 AM',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primary,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
