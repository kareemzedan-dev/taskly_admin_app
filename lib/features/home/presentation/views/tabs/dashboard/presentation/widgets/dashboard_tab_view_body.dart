import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/pending_action_section.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/trend_section.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/user_info_header.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/user_info_header_shimmer.dart';
import 'package:taskly_admin/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import 'package:taskly_admin/features/profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../../../../core/di/di.dart';
import '../../../../../../../../core/utils/strings_manager.dart';
import '../../../payments/presentation/manager/payments_view_model/payments_view_model.dart';
import '../../../payments/presentation/manager/payments_view_model/payments_view_model_states.dart';
import '../manager/get_all_orders_view_model/get_all_orders_states.dart';
import '../manager/get_all_orders_view_model/get_all_orders_view_model.dart';
import 'kpi_section.dart';

class DashboardTabViewBody extends StatelessWidget {
  const DashboardTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          BlocProvider(
            create:
                (context) =>
                    getIt<ProfileViewModel>()..getUserInfo(
                      SharedPrefHelper.getString(StringsManager.idKey)!,
                    ),
            child: BlocBuilder<ProfileViewModel, ProfileViewModelStates>(
              builder: (context, state) {
                if (state is ProfileViewModelStatesLoading) {
                  return UserInfoHomeHeaderShimmer();
                }
                if (state is ProfileViewModelStatesSuccess) {
                  return UserInfoHomeHeader(userInfo: state.userInfoEntity);
                }
                if (state is ProfileViewModelStatesError) {
                  return UserInfoHomeHeaderShimmer();
                }
                return UserInfoHomeHeaderShimmer();
              },
            ),
          ),
          SizedBox(height: 26.h),

          // KPI Section
          Text(
            local.kpiTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.h),
          KpiSection(),
          SizedBox(height: 26.h),

          // Charts Section
          Row(
            children: [
              Text(
                local.trendsTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorsManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  local.monthlyView,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorsManager.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const TrendsSection(),
          SizedBox(height: 12.h),
          Text(
            local.pendingActionsTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 10.h),
          const PendingActionSection(),
          SizedBox(height: 12.h),
          Text(
            local.exportCSVTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),

          SizedBox(height: 10.h),
          BlocProvider(
            create: (context) => getIt<PaymentsViewModel>()..loadPayments(),
            child: BlocBuilder<PaymentsViewModel, PaymentsViewModelStates>(
              builder: (context, state) {
                return CustomButton(
                  title: local.exportMoneyCSV,
                  icon: FontAwesomeIcons.download,
                  ontap: () async {
                    await context
                        .read<PaymentsViewModel>()
                        .exportPaymentsToCSV();
                  },
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            local.exportOrdersCSVTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 10.h),
          BlocProvider(
            create: (context) => getIt<GetAllOrdersViewModel>()..getAllOrders(),
            child: BlocBuilder<GetAllOrdersViewModel, GetAllOrdersStates>(
              builder: (context, state) {
                return CustomButton(
                  title: local.exportOrdersCSVTitle,
                  icon: FontAwesomeIcons.download,
                  ontap: () async {
                    final ordersVm = context.read<GetAllOrdersViewModel>();

                    if (state is GetAllOrdersSuccessState) {
                      await ordersVm.exportOrdersToCSV();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Orders not loaded yet!')),
                      );
                    }
                  },
                );
              },
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
