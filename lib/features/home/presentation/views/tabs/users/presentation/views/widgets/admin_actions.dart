import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/core/utils/strings_manager.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/chat_view.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/admin_action_button.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class AdminActions extends StatelessWidget {
  final UserEntity user;
  final bool isFreelancer;

  const AdminActions({
    super.key,
    required this.user,
    required this.isFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final newStatus = isFreelancer
        ? (user.freelancerStatus == "Active" ? "Deactivate" : "Active")
        : (user.clientStatus == "Active" ? "Deactivate" : "Active");


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         local.adminActions,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        AdminActionButton(
          label: local.activeDeactivate,
          icon: FontAwesomeIcons.ban,
          borderColor: Colors.red,
          textColor: Colors.red,
          onTap: () {
            context.read<UpdateUserStatusViewModel>().updateUserStatus(
              user.id,
                  status: newStatus ,
                role: user.role,
                isVerified: false
            );
          },
        ),
        SizedBox(height: 12.h),
        AdminActionButton(
          label: local.sendMessage,
          icon: Icons.message,
          borderColor: Colors.blue,
          textColor: Colors.blue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ChatView(
                      currentUserId:
                          SharedPrefHelper.getString(StringsManager.idKey)!,
                      receiverId: user.id,
                      currentUserRole: "admin",
                      receiverUserRole: user.role,
                      userName: user.fullName ?? '',
                      userImage: Assets.assetsImagesPortraitHappySmileyMan,
                      userLastSeen: user.lastSeen! ,
                      isOnline: user.isOnline ?? false,
                    ),
              ),
            );
          },
        ),
        SizedBox(height: 12.h),
     if (isFreelancer)
  BlocBuilder<UpdateUserStatusViewModel, UpdateUserStatusStates>(
    builder: (context, state) {
      bool isVerified = user.isVerified ?? false;

      if (state is UpdateUserStatusStatesSuccess && state.isVerified != null) {
        isVerified = state.isVerified!;
      }

      return AdminActionButton(
        label: isVerified ? local.unverify : local.verify,
        icon: Icons.remove_circle,
        borderColor: isVerified ? Colors.orange : Colors.green,
        textColor: isVerified ? Colors.orange : Colors.green,
        onTap: () {
          final newIsVerified = !isVerified;

          context.read<UpdateUserStatusViewModel>().updateUserStatus(
            user.id,
            role: user.role,
            isVerified: newIsVerified,
 
          );
        },
      );
    },
  ),

      ],
    );
  }
}
 