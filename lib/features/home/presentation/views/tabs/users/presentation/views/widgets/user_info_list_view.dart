import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/user_info_card.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/users_bottom_sheet_details.dart';

import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';

class UserInfoListView extends StatelessWidget {
  final List<UserEntity> users;
  final bool isFreelancer;

  const UserInfoListView({
    super.key,
    required this.users,
    this.isFreelancer = false,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(child: Text("No Users"));
    }

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserInfoCard(
          userEntity: user,
          isFreelancer: isFreelancer,

          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return BlocProvider.value(
                  value: getIt<UpdateUserStatusViewModel>(),
                  child: UsersBottomSheetDetails(
                    user: user,
                    isFreelancer: isFreelancer,
                  ),
                );
              },
            );
          },
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemCount: users.length,
    );
  }
}
