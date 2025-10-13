import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';

enum SenderType { client, freelancer , admin }

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final SenderType sender;
  final String avatarUrl;
  final bool  chatWithUsers;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.sender,
    required this.avatarUrl,
      this.chatWithUsers = false,
  });

  @override
  Widget build(BuildContext context) {
    final isClient = sender == SenderType.client;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isClient ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isClient) ...[
         UserAvatar(imagePath: avatarUrl , radius: 16.r,),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: isClient ? Colors.grey.shade300 : ColorsManager.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(isClient ? 0 : 16.r),
                  bottomRight: Radius.circular(isClient ? 16.r : 0),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isClient
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          isClient ? ColorsManager.black : ColorsManager.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: !isClient ? Colors.white : ColorsManager.black,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isClient) ...[
            SizedBox(width: 8.w),
                 if(chatWithUsers)
                   CircleAvatar( radius: 16.r, backgroundImage: AssetImage(Assets.assetsImagesAdminAvatar))

             else
                   UserAvatar(imagePath: avatarUrl , radius: 16.r,),
          ],
        ],
      ),
    );
  }
}
