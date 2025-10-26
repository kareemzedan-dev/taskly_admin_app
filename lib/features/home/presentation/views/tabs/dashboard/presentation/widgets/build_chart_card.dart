import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';

Widget buildChartCard(String title, Widget chart, {String? info,bool? restAll = true}) {
  return Card(
    elevation: 10,
    shadowColor: Colors.transparent,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(     color: ColorsManager.primary,),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.grey[800],
                ),
              ),
              Spacer(),
              if (restAll != false)
              Row(children: [
                Text("Rest All", style: TextStyle(fontSize: 12.sp, color: ColorsManager.primary),),
                SizedBox(width: 4.w),
                Icon(Icons.refresh, size: 18.sp, color: ColorsManager.primary),


              ],)
            ],
          ),

          if (info != null) ...[
            SizedBox(height: 4.h),
            Text(
              info,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
            ),
          ],

          SizedBox(height: 16.h),
          SizedBox(height: 200.h, child: chart),

        ],
      ),
    ),
  );
}
