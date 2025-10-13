import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../../../users/presentation/views/widgets/user_profile_info.dart';

class UserDetailsSection extends StatelessWidget {
  final String title;
 final UserEntity userEntity;
 final bool isFreelancer;

  const UserDetailsSection({
    super.key,
    required this.title,
 required this.userEntity,
    required this.isFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        AutoSizeText(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.black,
              ),
          maxLines: 1,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              imagePath: userEntity.profileImage,
              radius: 30.r,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: UserProfileInfo(
                fullName: userEntity.fullName!,
                email: userEntity.email,
                rating: userEntity.rating!,
                jobsCount: userEntity.jobsCount!,
                reviewsCount: userEntity.reviewsCount!,
                isFreelancer: isFreelancer,
              
                isVerified: userEntity.isVerified,
                freelancerStatus: userEntity.freelancerStatus,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
