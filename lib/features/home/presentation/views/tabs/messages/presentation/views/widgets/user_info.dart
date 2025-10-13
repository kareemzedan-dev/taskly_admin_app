import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String rating;
  final bool isFreelancer;
  final String? status;
  final String? freelancerStatus;

  const UserInfo({
    super.key,
    required this.name,
    required this.rating,
    required this.isFreelancer,
    this.status,
    this.freelancerStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isFreelancer
              ? Row(
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  if (isFreelancer) SizedBox(width: 4.w),
                  if (isFreelancer)
                    if (status != null)
                      Icon(
                        freelancerStatus!.trim().toLowerCase() == "verified"
                            ? Icons.verified
                            : Icons.error_outline,
                        color:
                            freelancerStatus!.trim().toLowerCase() == "verified"
                                ? ColorsManager.primary
                                : Colors.red,
                      ),
                ],
              )
              : Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
              ),

          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.grey.shade400,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  rating,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
