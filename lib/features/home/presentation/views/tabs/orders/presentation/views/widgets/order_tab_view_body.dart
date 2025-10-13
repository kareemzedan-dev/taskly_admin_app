import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/components/dismissible_error_card.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_orders_view_model/subscribe_to_orders_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_orders_view_model/subscribe_to_orders_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_card.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/search_with_filter_row.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import 'order_card_shimmer.dart';
import 'order_progress_card.dart';

class OrderTabViewBody extends StatefulWidget {
  const OrderTabViewBody({super.key});

  @override
  State<OrderTabViewBody> createState() => _OrderTabViewBodyState();
}
class _OrderTabViewBodyState extends State<OrderTabViewBody> {
  String searchQuery = ''; // هنا متغير الكلاس

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchWithFilterRow(
              hintTexts: [local.searchForOrder],
              onChanged: (index, value) {
                setState(() {
                  searchQuery = value;
                });
              },
              onFilterTap: () {
                final viewModel = context.read<SubscribeToOrdersViewModel>();
                // bottom sheet filter code
              },
            ),
            SizedBox(height: 20.h),
            Divider(thickness: 1, color: Colors.grey),
            Expanded(
              child: BlocConsumer<SubscribeToOrdersViewModel, SubscribeToOrdersStates>(
                listener: (context, state) {
                  if (state is SubscribeToOrdersStatesError) {
                    showTemporaryMessage(
                      context,
                      local.errorPrefix(state.message),
                      MessageType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SubscribeToOrdersStatesLoading) {
                    return const OrderCardShimmer();
                  }

                  if (state is SubscribeToOrdersStatesSuccess) {
                    final newOrders = state.orders.where((o) =>
                    o.status == OrderStatus.Pending ||

                        o.status == OrderStatus.Accepted ||
                        o.status == OrderStatus.Paid);

                    final progressOrders =
                    state.orders.where((o) => o.status == OrderStatus.InProgress||o.status == OrderStatus.Waiting);

                    final deliveredOrders =
                    state.orders.where((o) => o.status == OrderStatus.Completed);

                    final cancelledOrders =
                    state.orders.where((o) => o.status == OrderStatus.Cancelled);

                    return Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.only(right: 16.w),
                          indicatorPadding: EdgeInsets.zero,
                          tabAlignment: TabAlignment.center,
                          labelColor: ColorsManager.primary,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          indicatorColor: ColorsManager.primary,
                          indicatorWeight: 4,
                          tabs: [
                            _buildTab(local.newOrder, newOrders.length),
                            _buildTab(local.progress, progressOrders.length),
                            _buildTab(local.delivered, deliveredOrders.length),
                            _buildTab(local.cancelled, cancelledOrders.length),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(thickness: 1, color: Colors.grey),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildOrdersList(newOrders.toList(), false, local),
                              _buildOrdersList(progressOrders.toList(), true, local),
                              _buildOrdersList(deliveredOrders.toList(), true, local),
                              _buildOrdersList(cancelledOrders.toList(), true, local),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return const OrderCardShimmer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<OrderEntity> orders, bool isProgress, AppLocalizations local) {
    final filteredOrders = orders.where((order) {
      final query = searchQuery.toLowerCase();
      return order.title.toLowerCase().contains(query) ||
          order.id.toLowerCase().contains(query) ||
          order.status.name.toLowerCase().contains(query) ||
          order.clientId.toLowerCase().contains(query);
    }).toList();

    if (filteredOrders.isEmpty) return Center(child: Text(local.noOrdersHere));

    return ListView.separated(
      itemCount: filteredOrders.length,
      separatorBuilder: (_, __) => const Divider(thickness: 1, color: Colors.grey),
      itemBuilder: (_, index) => isProgress
          ? OrderProgressCard(order: filteredOrders[index])
          : OrderCard(order: filteredOrders[index]),
    );
  }



  Tab _buildTab(String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: ColorsManager.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSheet(
      SubscribeToOrdersViewModel viewModel, BuildContext context, AppLocalizations local) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Text(
            local.filtersTooltip,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.list, color: Colors.blue),
            title: Text(local.all),
            onTap: () {
              Navigator.pop(context);
              viewModel.changeFilter(OrderFilter.all);
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule, color: Colors.orange),
            title: Text(local.delayed),
            onTap: () {
              Navigator.pop(context);
              viewModel.changeFilter(OrderFilter.delayed);
            },
          ),
        ],
      ),
    );
  }
}
