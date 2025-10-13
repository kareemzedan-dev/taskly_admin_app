import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/pending_action_Item.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../../../../core/utils/colors_manger.dart';
import '../manager/late_orders_view_model/late_orders_states.dart';
import '../manager/late_orders_view_model/late_orders_view_model.dart';
import '../manager/pending_payments_view_model/pending_payments_states.dart';
import '../manager/pending_payments_view_model/pending_payments_view_model.dart';
import '../manager/pending_verifications_view_case/pending_verifications_states.dart';
import '../manager/pending_verifications_view_case/pending_verifications_view_model.dart';


class PendingActionSection extends StatelessWidget {
  const PendingActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.primary),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          /// Pending Verifications
          BlocBuilder<PendingVerificationsViewModel, PendingVerificationsStates>(
            builder: (context, state) {
              if (state is PendingVerificationsStatesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PendingVerificationsStatesSuccess) {
                return PendingActionItem(
                  icon: Icons.verified_user,
                  label: local.pendingVerifications,
                  count: state.users.length,
                );
              } else if (state is PendingVerificationsStatesError) {
                return PendingActionItem(
                  icon: Icons.error,
                  label: local.pendingVerifications,
                  count: 0,
                );
              }
              return const SizedBox.shrink();
            },
          ),

          SizedBox(height: 12.h),

          /// Pending Payments
          BlocBuilder<PendingPaymentsViewModel, PendingPaymentsStates>(
            builder: (context, state) {
              if (state is PendingPaymentsStatesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PendingPaymentsStatesSuccess) {
                return PendingActionItem(
                  icon: Icons.payment,
                  label: local.pendingPayments,
                  count: state.pendingPayments.length,
                );
              } else if (state is PendingPaymentsStatesError) {
                return PendingActionItem(
                  icon: Icons.payment,
                  label: local.pendingPayments,
                  count: 0,
                );
              }
              return const SizedBox.shrink();
            },
          ),

          SizedBox(height: 12.h),

          /// Late Orders
          BlocBuilder<LateOrdersViewModel, LateOrdersStates>(
            builder: (context, state) {
              if (state is LateOrdersStatesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LateOrdersStatesSuccess) {
                return PendingActionItem(
                  icon: Icons.schedule,
                  label: local.lateOrders,
                  count: state.lateOrders.length,
                );
              } else if (state is LateOrdersStatesError) {
                return PendingActionItem(
                  icon: Icons.schedule,
                  label: local.lateOrders,
                  count: 0,
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
