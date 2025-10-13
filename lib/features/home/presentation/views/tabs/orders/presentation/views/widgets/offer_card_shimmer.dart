import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OfferCardShimmer extends StatelessWidget {
  const OfferCardShimmer({super.key});

  Widget _buildShimmerContainer({double? width, double? height, BorderRadius? borderRadius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: borderRadius ?? BorderRadius.circular(4.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info + Price Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User Info
                    Row(
                      children: [
                        _buildShimmerContainer(
                          width: 40.r,
                          height: 40.r,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerContainer(width: 120.w, height: 16.h),
                            SizedBox(height: 6.h),
                            _buildShimmerContainer(width: 160.w, height: 14.h),
                            SizedBox(height: 6.h),
                            Row(
                              children: List.generate(5, (index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 4.w),
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Price & Duration
                    Column(
                      children: [
                        _buildShimmerContainer(width: 60.w, height: 30.h, borderRadius: BorderRadius.circular(10.r)),
                        SizedBox(height: 5.h),
                        _buildShimmerContainer(width: 40.w, height: 14.h),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Offer Description
                _buildShimmerContainer(width: double.infinity, height: 50.h, borderRadius: BorderRadius.circular(4.r)),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
