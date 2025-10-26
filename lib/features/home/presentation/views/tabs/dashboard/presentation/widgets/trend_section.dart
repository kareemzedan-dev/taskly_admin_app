import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/revenue_statistics_view_model/revenue_statistics_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/revenue_statistics_view_model/revenue_statistics_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/revenue_trend_chart.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/category_distribution_view_model/category_distribution_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/category_distribution_view_model/category_distribution_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/category_distribution_chart.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/order_volume_chart.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/build_chart_card.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class TrendsSection extends StatefulWidget {
  const TrendsSection({super.key});

  @override
  State<TrendsSection> createState() => _TrendsSectionState();
}

class _TrendsSectionState extends State<TrendsSection> {
  late final RevenueStatisticsViewModel revenueVM;
  late final GetAllOrdersViewModel ordersVM;
  late final CategoryDistributionViewModel categoryVM;

  @override
  void initState() {
    super.initState();
    revenueVM = getIt<RevenueStatisticsViewModel>()..getRevenueStatistics('weekly');
    ordersVM = getIt<GetAllOrdersViewModel>()..getAllOrders();
    categoryVM = getIt<CategoryDistributionViewModel>()..getCategoryDistribution();

  }

  @override
  void dispose() {
    revenueVM.close();
    ordersVM.close();
    categoryVM.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: revenueVM),
        BlocProvider.value(value: ordersVM),
        BlocProvider.value(value: categoryVM),
      ],
      child: Column(
        children: [
          /// 🔹 Revenue Trend (using new RevenueStatisticsViewModel)
          buildChartCard(
            local.revenueTrend,
            BlocBuilder<RevenueStatisticsViewModel, RevenueStatisticsStates>(
              builder: (context, state) {
                if (state is RevenueStatisticsStatesLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is RevenueStatisticsStatesError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is RevenueStatisticsStatesSuccess) {
                  return RevenueTrendChart(revenueStatistics: state.revenueStatistics);
                }
                return const SizedBox.shrink();
              },
            ),
            info: local.totalRevenueInfo,
          ),

          SizedBox(height: 16.h),

          /// 🔹 Order Volume Chart
          buildChartCard(
            local.orderVolume,
            BlocBuilder<RevenueStatisticsViewModel, RevenueStatisticsStates>(
              builder: (context, state) {
                if (state is RevenueStatisticsStatesLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is RevenueStatisticsStatesError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is RevenueStatisticsStatesSuccess) {
                  return OrderVolumeChart(orders: state.revenueStatistics);
                }
                return const SizedBox.shrink();
              },
            ),
            info: local.dailyOrderInfo,
          ),

          SizedBox(height: 16.h),

          /// 🔹 Category Distribution Chart
          buildChartCard(
            local.categoryDistribution,
            restAll: false,
            BlocBuilder<CategoryDistributionViewModel, CategoryDistributionStates>(
              builder: (context, state) {
                if (state is CategoryDistributionLoadingState) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is CategoryDistributionErrorState) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is CategoryDistributionLoadedState) {
                  return CategoryDistributionWithLegend(data: state.categoryDistribution);
                }
                return const SizedBox.shrink();
              },
            ),
            info: local.serviceCategoryInfo,
          ),
        ],
      ),
    );
  }
}
