import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/filters_view_model/filters_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_all_users_view_model/get_all_users_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/users_tab_view_body.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class UsersTabView extends StatelessWidget {
  const UsersTabView({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: local.manageUsers,
        image: Assets.assetsImagesUser12366536,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<GetAllUsersViewModel>()..getAllUsers(),
          ),
          BlocProvider(create: (_) => FilterViewModel(local.all)),
        ],
        child: UsersTabViewBody(initialIndex: initialIndex),
      ),
    );
  }
}
