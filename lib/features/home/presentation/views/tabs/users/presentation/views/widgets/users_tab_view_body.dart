import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/components/custom_tab_bar.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/filters_view_model/filters_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/search_with_filter_row.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/user_info_card_shimmer.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/user_info_list_view.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../manager/get_all_users_view_model/get_all_users_states.dart';
import '../../manager/get_all_users_view_model/get_all_users_view_model.dart';
import 'filter_bottom_sheet_content.dart';

class UsersTabViewBody extends StatefulWidget {
  UsersTabViewBody({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<UsersTabViewBody> createState() => _UsersTabViewBodyState();
}

class _UsersTabViewBodyState extends State<UsersTabViewBody> {
  String nameQuery = "";

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialIndex,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchWithFilterRow(
              hintTexts: [local.searchByName],
              onChanged: (index, value) {
                setState(() {
                  if (index == 0) nameQuery = value;
                });
              },
              onFilterTap: () {
                final usersVM = context.read<GetAllUsersViewModel>();
                final filterVM = context.read<FilterViewModel>();

                showModalBottomSheet(
                  context: context,
                  builder: (bottomSheetContext) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: usersVM),
                        BlocProvider.value(value: filterVM),
                      ],
                      child: const FilterBottomSheetContent(),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16.h),
            BlocBuilder<GetAllUsersViewModel, GetAllUsersStates>(
              builder: (context, state) {
                if (state is GetAllUsersSuccessState) {
                  return CustomTabBar(
                    tabs: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(local.clients),
                          SizedBox(width: 6.w),
                          _countBadge(state.clientsCount),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(local.freelancers),
                          SizedBox(width: 6.w),
                          _countBadge(state.freelancersCount),
                        ],
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Divider(thickness: 1, color: Colors.grey),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<GetAllUsersViewModel, GetAllUsersStates>(
                builder: (context, state) {
                  if (state is GetAllUsersLoadingState) {
                    return TabBarView(
                      children: [_shimmerList(), _shimmerList()],
                    );
                  }

                  if (state is GetAllUsersErrorState) {
                    return Center(child: Text(state.message));
                  }

                  if (state is GetAllUsersSuccessState) {
                    final clients = state.users
                        .where((u) => u.role == 'client' && u.fullName!.toLowerCase().contains(nameQuery.toLowerCase()))

                        .toList();

                    final freelancers = state.users
                        .where((u) => u.role == 'freelancer' && u.fullName!.toLowerCase().contains(nameQuery.toLowerCase()))
                        .toList();

                    return TabBarView(
                      children: [
                        UserInfoListView(users: clients),
                        UserInfoListView(users: freelancers, isFreelancer: true),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countBadge(int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(color: Colors.white, fontSize: 12.sp),
      ),
    );
  }

  Widget _shimmerList() {
    return ListView.separated(
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (_, __) => const UserInfoCardShimmer(),
    );
  }
}
