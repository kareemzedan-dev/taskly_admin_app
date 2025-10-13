import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(8.w),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            border: Border.all(color: ColorsManager.primary.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white, // خلي خلفية بيضا عشان الشيمر يبان
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Avatar + Name + Status
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100.w,
                            height: 12.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            width: 60.w,
                            height: 10.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 70.w,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  /// Order title
                  Container(
                    width: double.infinity,
                    height: 14.h,
                    color: Colors.white,
                  ),

                  SizedBox(height: 10.h),

                  /// Description
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.white,
                  ),

                  SizedBox(height: 12.h),

                  /// Progress
                  Row(
                    children: List.generate(
                      4,
                          (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(height: 36.h, color: Colors.white),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(height: 36.h, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
