import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taskly_admin/core/utils/app_text_styles.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class UserInfoSection extends StatelessWidget {
  final String name, email;
  final double rating;
  final bool isFreelancer;
  final bool photoSizeSelected;
  final bool emailShow;
  final String imagePath;

  const UserInfoSection({
    super.key,
    required this.name,
    required this.email,
    this.rating = 1.0,
    this.isFreelancer = false,
    this.photoSizeSelected = false,
    this.emailShow = true,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(imagePath: imagePath, radius: photoSizeSelected ? 25.r : 20.r),
        SizedBox(width: 10.w),


        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                minFontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
              if (emailShow)
                AutoSizeText(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < rating.round() ? CupertinoIcons.star_fill : CupertinoIcons.star,
                      color: Colors.amber,
                      size: 14.sp,
                    );
                  }),
                  SizedBox(width: 8.w),
                  AutoSizeText(
                    '(${rating.toStringAsFixed(1)})',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                    maxLines: 1,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              if (isFreelancer)
                Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Colors.green,
                      size: 14.sp,
                    ),
                    SizedBox(width: 5.w),
                    AutoSizeText(
                      local.verifiedFreelancer,
                      style: AppTextStyles.bold14.copyWith(color: Colors.grey),
                      maxLines: 1,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
