import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/helper/get_status_color.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_info.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_status_and_time.dart';

 
 
   
class MessagesCard extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final String message;
  final String time;
  final String status;
  final Color statusColor;
  final String? imagePath;
  final bool isFreelancer;
  final double rating;

  const MessagesCard({
    super.key,
    required this.onTap,
    required this.name,
    required this.message,
    required this.time,
    required this.status,
    required this.statusColor,
    this.imagePath,
    required this.isFreelancer,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
        final statusColor = getStatusColor(
      isFreelancer ?status : status,
    );
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsManager.primary.withOpacity(.5)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            UserAvatar(imagePath: imagePath),
            SizedBox(width: 8.w),
            UserInfo(name: name, rating: rating.toString(),isFreelancer: isFreelancer, freelancerStatus: status,status:  status,),
            UserStatusAndTime(
              status: status,
              statusColor: statusColor,

            ),
          ],
        ),
      ),
    );
  }
}
