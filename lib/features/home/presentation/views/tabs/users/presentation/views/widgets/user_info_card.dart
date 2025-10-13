// user_info_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/helper/get_status_color.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/user_profile_info.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class UserInfoCard extends StatelessWidget {
  final UserEntity userEntity;
  final VoidCallback? onTap;
  final bool isFreelancer;

  const UserInfoCard({
    super.key,
    required this.userEntity,
    this.onTap,
    this.isFreelancer = false,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final statusColor = getStatusColor(
      isFreelancer ? userEntity.freelancerStatus : userEntity.clientStatus,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة + الحالة
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorsManager.primary,
                      width: 1.2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: userEntity.profileImage != null &&
                        userEntity.profileImage!.isNotEmpty
                        ? NetworkImage(userEntity.profileImage!)
                        : const AssetImage(
                      Assets.assetsImagesUsersAvatar,
                    ) as ImageProvider,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    isFreelancer
                        ? (userEntity.freelancerStatus ?? local.unassigned)
                        : (userEntity.clientStatus ?? local.unassigned),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 10.w),


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

            SizedBox(width: 10.w),

            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorsManager.primary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
