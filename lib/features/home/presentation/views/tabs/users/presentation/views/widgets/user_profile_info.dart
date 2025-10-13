// user_profile_info.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';

class UserProfileInfo extends StatelessWidget {
  final String fullName;
  final String email;
  final double rating;
  final int jobsCount;
  final int reviewsCount;
  final bool isFreelancer;
  final bool? isVerified;
  final String? freelancerStatus;

  const UserProfileInfo({
    super.key,
    required this.fullName,
    required this.email,
    required this.rating,
    required this.jobsCount,
    required this.reviewsCount,
    this.isFreelancer = false,
    this.isVerified,
    this.freelancerStatus,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min, // مهم
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AutoSizeText(
                fullName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                minFontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isFreelancer)
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Icon(
                  isVerified ?? false ? Icons.verified : Icons.error_outline,
                  size: 16.sp,
                  color: (isVerified ?? false)
                      ? ColorsManager.primary
                      : Colors.red,
                ),
              ),
            SizedBox(width: 8.w),
            Flexible(
              child: AutoSizeText(
                '($jobsCount ${local.jobs})',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        AutoSizeText(
          email,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          minFontSize: 10,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 20.sp),
            SizedBox(width: 4.w),
            AutoSizeText(
              rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 16.w),
            Flexible(
              child: AutoSizeText(
                '($reviewsCount ${local.reviews})',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
