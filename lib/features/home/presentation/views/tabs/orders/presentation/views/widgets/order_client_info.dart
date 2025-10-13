import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';

class OrderUserInfo extends StatelessWidget {
  final UserEntity userEntity;

  const OrderUserInfo({super.key, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(imagePath: userEntity.profileImage, radius: 20.r),
        SizedBox(width: 6.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userEntity.fullName} (${userEntity.role})",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 18.sp),
                SizedBox(width: 4.w),
                Text(
                  userEntity.rating.toString(),
                  style: TextStyle(fontSize: 13.sp),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
