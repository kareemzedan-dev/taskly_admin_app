import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../../../../core/utils/assets_manager.dart';

class UserInfoHomeHeader extends StatelessWidget {
  final UserEntity userInfo;

  const UserInfoHomeHeader({super.key, required this.userInfo});

  @override Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(local.hiUser(userInfo.fullName ?? ""), style: Theme
            .of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w600),),
        Text(local.welcomeTaskly, style: Theme
            .of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(
          fontWeight: FontWeight.w800, fontSize: 18.sp,),),
      ],), CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      radius: 30.r,
      backgroundImage:   AssetImage(
          Assets.assetsImagesAdminAvatar) as ImageProvider,),
    ],);
  }
}