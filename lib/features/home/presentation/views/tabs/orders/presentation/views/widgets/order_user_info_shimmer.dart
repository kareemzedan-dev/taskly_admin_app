import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OrderUserInfoShimmer extends StatelessWidget {
  const OrderUserInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          // Avatar shimmer
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),

          // Text shimmer (name + rating)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full name + role
              Container(
                width: 120.w,
                height: 14.h,
                color: Colors.white,
              ),
              SizedBox(height: 6.h),

              // Rating row
              Row(
                children: [
                  Container(
                    width: 18.r,
                    height: 18.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    width: 30.w,
                    height: 12.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
