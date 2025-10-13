import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taskly_admin/config/routes/routes_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_all_users_view_model/get_all_users_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_all_users_view_model/get_all_users_states.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manger.dart';
import 'dashboard_info_card.dart';

class KpiSection extends StatelessWidget {
  const KpiSection({super.key});

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 160.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.primary),
        borderRadius: BorderRadius.circular(10.r),
        color: ColorsManager.primary.withOpacity(.08),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BlocBuilder<GetAllOrdersViewModel, GetAllOrdersStates>(
            builder: (context, ordersState) {
              if (ordersState is GetAllOrdersLoadingState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildShimmerCard()),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildShimmerCard()),
                  ],
                );
              }

              if (ordersState is GetAllOrdersSuccessState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DashboardInfoCard(
                        onTap: () {

                        },
                        title: local.dashboardOrders,
                        value: "${ordersState.totalOrders}",
                        icon: Icons.shopping_bag,
                        backgroundImage: Assets.assetsImagesTotalOrders,
                        overlayColor: Colors.orange,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: DashboardInfoCard(
                        onTap: (){},
                        title: local.dashboardEarnings,
                        value:
                        "\$${ordersState.totalEarnings.toStringAsFixed(2)}",
                        icon: Icons.attach_money,
                        backgroundImage: Assets.assetsImagesTotalRevenue,
                        overlayColor: Colors.green,
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: 12.h),
          BlocBuilder<GetAllUsersViewModel, GetAllUsersStates>(
            builder: (context, usersState) {
              if (usersState is GetAllUsersLoadingState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildShimmerCard()),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildShimmerCard()),
                  ],
                );
              }

              if (usersState is GetAllUsersSuccessState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DashboardInfoCard(
                        onTap: (){},
                        title: local.dashboardClients,
                        value: "${usersState.clientsCount}",
                        icon: Icons.person,
                        backgroundImage: Assets.assetsImagesTotalClients,
                        overlayColor: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: DashboardInfoCard(
                        onTap: (){},
                        title: local.dashboardFreelancers,
                        value: "${usersState.freelancersCount}",
                        icon: Icons.work,
                        backgroundImage: Assets.assetsImagesTotalFreelancers,
                        overlayColor: Colors.purple,
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
