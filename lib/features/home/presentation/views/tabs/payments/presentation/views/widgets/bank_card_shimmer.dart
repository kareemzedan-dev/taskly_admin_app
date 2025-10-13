import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BankCardShimmer extends StatelessWidget {
  const BankCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // --- header row ---
              Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14.h,
                        width: 120.w,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        height: 12.h,
                        width: 80.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 24.h,
                    width: 60.w,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // --- details placeholders ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 14.h, width: 100.w, color: Colors.white),
                  Container(height: 14.h, width: 80.w, color: Colors.white),
                  Container(height: 14.h, width: 60.w, color: Colors.white),
                ],
              ),
              SizedBox(height: 16.h),

              Container(
                height: 40.h,
                width: double.infinity,
                color: Colors.white,
              ),
              SizedBox(height: 10.h),
              Container(
                height: 40.h,
                width: double.infinity,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
