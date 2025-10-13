import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/send_message_view_model/send_message_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/chat_view_body.dart';
import '../../../../../../../../core/di/di.dart';
import '../../../../../../../../core/helper/format_last_seen.dart';
import '../../../../../../../attachments/presentation/manager/download_attachments_view_model/download_attachments_view_model.dart';
import '../manager/user_status_view_model/user_status_states.dart';
import '../manager/user_status_view_model/user_status_view_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.userName,
    required this.userImage,
    required this.currentUserId,
    required this.receiverId,
    required this.currentUserRole,
    required this.receiverUserRole,
    required this.userLastSeen,
    required this.isOnline,
  });

  final String userName;
  final String userImage;
  final String currentUserId;
  final String receiverId;
  final String currentUserRole;
  final String receiverUserRole;
  final DateTime userLastSeen;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<DownloadAttachmentsViewModel>()),
        BlocProvider(create: (_) => getIt<SendMessageViewModel>(), ),
        BlocProvider(create: (_) => getIt<UserStatusViewModel>()..streamUserStatus(receiverId)),
      ],
      child: Directionality(
        textDirection: Localizations.localeOf(context).languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          appBar:AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            toolbarHeight: 70.h,
            elevation: 0,
            shape: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.grey.shade500,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 20.r,
                  backgroundImage: (userImage.isNotEmpty && userImage.startsWith('http'))
                      ? NetworkImage(userImage)
                      : const AssetImage(Assets.assetsImagesUsersAvatar) as ImageProvider,
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    BlocBuilder<UserStatusViewModel, UserStatusStates>(
                      builder: (context, state) {
                        final status = state is UserStatusSuccessStates
                            ? state.userStatus
                            : null;
                        return Text(
                          formatLastSeen(
                            isOnline: status?.isOnline ?? isOnline,
                            lastSeen: status?.lastSeen ?? userLastSeen,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: (status?.isOnline ?? isOnline) ? Colors.green : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: false, // يخلي الـ title على حسب اتجاه الـ language
          ),

          backgroundColor: Colors.white,
          body: SafeArea(
            child: ChatViewBody(
              currentUserId: currentUserId,
              receiverId: receiverId,
              currentUserRole: currentUserRole,
              receiverUserRole: receiverUserRole,
            ),
          ),
        ),
      ),
    );
  }
}
