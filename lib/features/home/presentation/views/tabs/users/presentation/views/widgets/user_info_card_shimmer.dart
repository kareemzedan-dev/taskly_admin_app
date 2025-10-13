import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class UserInfoCardShimmer extends StatelessWidget {
  const UserInfoCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.primary.withOpacity(.5),
            width: 1.2,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side (avatar + status)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    // Avatar placeholder
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 4.h),
                    // Status placeholder
                    Container(
                      width: 60.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                // Info placeholders
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 16.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          width: 60.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 140.w,
                      height: 14.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 30.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          width: 80.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Arrow placeholder
            Container(
              width: 20.w,
              height: 20.w,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
