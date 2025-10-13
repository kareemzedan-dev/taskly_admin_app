import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_user_info_shimmer.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'package:taskly_admin/core/di/di.dart';

import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import 'user_info_section.dart';

class UserInfoLoader extends StatelessWidget {
  final String userId;
  final String roleLabel;
  final Function(UserEntity) onLoaded;

  const UserInfoLoader({
    super.key,
    required this.userId,
    required this.roleLabel,
    required this.onLoaded,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) =>
      getIt<GetUserInfoByIdViewModel>()..getUserInfoById(userId),
      child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
        builder: (context, state) {
          if (state is GetUserInfoByIdLoading) {
            return const OrderUserInfoShimmer();
          }

          if (state is GetUserInfoByIdSuccess) {
            final user = state.userEntity;
            onLoaded(user);

            return UserInfoSection(
              name: user.fullName!,
              email: user.email,
              rating: user.rating ?? 0,
              isFreelancer: roleLabel == local.freelancer,
              photoSizeSelected: true,
              imagePath:  user.profileImage!,

            );
          }

          return const OrderUserInfoShimmer();
        },
      ),
    );
  }
}
