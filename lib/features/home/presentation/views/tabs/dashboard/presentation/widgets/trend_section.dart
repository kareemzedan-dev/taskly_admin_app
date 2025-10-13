import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/revenue_trend_chart.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/admin_payments_view_model/admin_payments_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/admin_payments_view_model/admin_payments_view_model_states.dart';
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
  late final AdminPaymentsViewModel paymentsVM;
  late final GetAllOrdersViewModel ordersVM;
  late final CategoryDistributionViewModel categoryVM;

  @override
  void initState() {
    super.initState();
    paymentsVM = getIt<AdminPaymentsViewModel>()..getAllPayments();
    ordersVM = getIt<GetAllOrdersViewModel>()..getAllOrders();
    categoryVM = getIt<CategoryDistributionViewModel>()..getCategoryDistribution();
  }

  @override
  void dispose() {
    paymentsVM.close();
    ordersVM.close();
    categoryVM.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: paymentsVM),
        BlocProvider.value(value: ordersVM),
        BlocProvider.value(value: categoryVM),
      ],
      child: Column(
        children: [
          buildChartCard(
            local.revenueTrend,
            BlocBuilder<AdminPaymentsViewModel, AdminPaymentsViewModelStates>(
              builder: (context, state) {
                if (state is AdminPaymentsViewModelLoadingState) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is AdminPaymentsViewModelErrorState) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is AdminPaymentsViewModelSuccessState) {
                  return RevenueTrendChart(payments: state.payments);
                }
                return const SizedBox.shrink();
              },
            ),
            info: local.totalRevenueInfo,
          ),
          SizedBox(height: 16.h),
          buildChartCard(
            local.orderVolume,
            BlocBuilder<GetAllOrdersViewModel, GetAllOrdersStates>(
              builder: (context, state) {
                if (state is GetAllOrdersLoadingState) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is GetAllOrdersErrorState) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is GetAllOrdersSuccessState) {
                  return OrderVolumeChart(orders: state.orders);
                }
                return const SizedBox.shrink();
              },
            ),
            info: local.dailyOrderInfo,
          ),
          SizedBox(height: 16.h),
          buildChartCard(
            local.categoryDistribution,
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
