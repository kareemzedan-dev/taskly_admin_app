import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/components/custom_search_text_field.dart';
import 'package:taskly_admin/core/components/custom_tab_bar.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/payments_view_model/payments_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/payments_view_model/payments_view_model_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/bank_header_container.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/tab_item_with_counter.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/custom_payment_status_card.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../l10n/app_localizations.dart';

class PaymentTabViewBody extends StatefulWidget {
  const PaymentTabViewBody({super.key});

  @override
  State<PaymentTabViewBody> createState() => _PaymentTabViewBodyState();
}

class _PaymentTabViewBodyState extends State<PaymentTabViewBody>
    with TickerProviderStateMixin
{
  late TabController mainTabController; // clients / freelancers
  late TabController statusTabController; // pending / approved / rejected
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    mainTabController = TabController(length: 2, vsync: this);
    statusTabController = TabController(length: 3, vsync: this);
    context.read<PaymentsViewModel>().loadPayments();

    // 👇 أضف ده
    mainTabController.addListener(() {
      if (!mainTabController.indexIsChanging) {
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    mainTabController.dispose();
    statusTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        BankHeaderContainer(
          title: local.bankAccountManagement,
          iconAsset: Assets.assetsImagesMoney10894489,
          onTap: () {
            Navigator.pushNamed(context, RoutesManager.bankAccountView);
          },
        ),
        SizedBox(height: 16.h),
        CustomTabBar(
          tabs: [
            Text(local.clientPayments),
            Text(local.freelancerWithdrawals),
          ],
          controller: mainTabController,
        ),
        SizedBox(height: 8.h),
        Divider(thickness: 1, color: Colors.grey.shade300),
        SizedBox(height: 8.h),

        // 🔍 Search مرة واحدة
        Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomSearchTextField(
            hintTexts: [local.searchPayments],
            onChanged: (value) => setState(() => searchQuery = value),
          ),
        ),
        BlocBuilder<PaymentsViewModel, PaymentsViewModelStates>(
          builder: (context, state) {
            final vm = context.read<PaymentsViewModel>();

            return CustomTabBar(
              isScrollable: true,
              controller: statusTabController,
              tabAlignment: TabAlignment.center,
              tabs: [
                TabItemWithCounter(
                  icon: Icons.pending_actions,
                  iconColor: Colors.amber,
                  title: local.pending,
                  count: vm.countPayments(
                    isClient: mainTabController.index == 0,
                    status: "pending",
                  ),
                ),
                TabItemWithCounter(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: local.accepted,
                  count: vm.countPayments(
                    isClient: mainTabController.index == 0,
                    status: "approved",
                  ),
                ),
                TabItemWithCounter(
                  icon: Icons.cancel,
                  iconColor: Colors.red,
                  title: local.rejected,
                  count: vm.countPayments(
                    isClient: mainTabController.index == 0,
                    status: "rejected",
                  ),
                ),
              ],
            );
          },
        ),


        SizedBox(height: 8.h),

        // 🧾 عرض الداتا
        Expanded(
          child: TabBarView(
            controller: mainTabController,
            children: [
              _PaymentsList(
                isClient: true,
                statusTabController: statusTabController,
                searchQuery: searchQuery,
              ),
              _PaymentsList(
                isClient: false,
                statusTabController: statusTabController,
                searchQuery: searchQuery,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PaymentsList extends StatelessWidget {
  final bool isClient;
  final TabController statusTabController;
  final String searchQuery;

  const _PaymentsList({
    required this.isClient,
    required this.statusTabController,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsViewModel, PaymentsViewModelStates>(
      builder: (context, state) {
        if (state is PaymentsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaymentsErrorState) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is PaymentsSuccessState) {
          final vm = context.read<PaymentsViewModel>();

          return TabBarView(
            controller: statusTabController,
            children: ["pending", "approved", "rejected"].map((status) {
              final filtered = vm.filterPayments(
                isClient: isClient,
                status: status,
              ).where((p) {
                final q = searchQuery.toLowerCase();
                return p.id.toLowerCase().contains(q) ||
                    p.amount.toString().contains(q);
              }).toList();

              if (filtered.isEmpty) {
                return const Center(child: Text("No data available"));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: CustomPaymentStatusCard(
                      payment: filtered[i],
                      isFreelancer: !isClient,
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _StatusList extends StatelessWidget {
  final bool isClient;
  final String status;
  final String searchQuery;

  const _StatusList({
    required this.isClient,
    required this.status,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsViewModel, PaymentsViewModelStates>(
      builder: (context, state) {
        if (state is PaymentsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaymentsErrorState) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is PaymentsSuccessState) {
          final vm = context.read<PaymentsViewModel>();
          final filtered = vm.filterPayments(
            isClient: isClient,
            status: status,
          ).where((p) {
            final query = searchQuery.toLowerCase();
            return p.id.toLowerCase().contains(query) ||

                p.amount.toString().contains(query);
          }).toList();

          if (filtered.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CustomPaymentStatusCard(
                  payment: filtered[index],
                  isFreelancer: !isClient,
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
