import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taskly_admin/core/helper/get_status_color.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../../core/utils/users_status_local_extension.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../../../messages/presentation/views/widgets/user_avatar.dart';

class UserHeaderSection extends StatelessWidget {
  final UserEntity user;
  final bool isFreelancer;
  final VoidCallback? onTap;

  const UserHeaderSection({
    super.key,
    required this.user,
    required this.isFreelancer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(
      isFreelancer ? user.freelancerStatus : user.clientStatus,
    );

    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة
          UserAvatar(imagePath: user.profileImage),
          SizedBox(width: 10.w),

          // معلومات المستخدم
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AutoSizeText(
                      user.fullName ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 5.w),
                    if (isFreelancer && user.freelancerStatus != null)
                      Icon(
                        user.isVerified! ? Icons.verified : Icons.error_outline,
                        color: user.isVerified! ? ColorsManager.primary : Colors.red,
                        size: 16.sp,
                      ),
                  ],
                ),
                SizedBox(height: 2.h),
                AutoSizeText(
                  user.email,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(Icons.star, color: ColorsManager.primary, size: 16.sp),
                    SizedBox(width: 4.w),
                    AutoSizeText(
                      user.rating?.toStringAsFixed(1) ?? '0.0',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 10.w),

          // الحالة
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: AutoSizeText(
              isFreelancer
                  ? (user.freelancerStatus?.toLocalizedStatus(context) ?? '')
                  : (user.clientStatus?.toLocalizedStatus(context) ?? ''),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),

          ),
        ],
      ),
    );
  }
}
