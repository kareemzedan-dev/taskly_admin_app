import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'order_actions_section.dart';
import 'order_budget_text.dart';
import 'order_deadline_badge.dart';
import 'order_description.dart';
import 'order_header_section.dart';
import 'order_progress_section.dart';
import 'order_user_section.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    List<String> steps = _getSteps(local);

    final isLate = DateTime.now().isAfter(order.deadline!);

    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLate ? Colors.red.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: isLate ? Border.all(color: Colors.red, width: 1.5) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLate) OrderDeadlineBadge(label: local.deadlineExpired),
              SizedBox(height: 8.h),
              OrderUserSection(clientId: order.clientId),
              SizedBox(height: 8.h),
              OrderHeaderSection(order: order),
              SizedBox(height: 8.h),
              OrderDescription(description: order.description ?? ""),
              SizedBox(height: 8.h),
              OrderProgressSection(order: order, steps: steps),
              SizedBox(height: 8.h),
              if (order.status.name != OrderStatus.Cancelled.name)
                OrderBudgetText(order: order),
              SizedBox(height: 8.h),



                    OrderActionsSection(
                    order: order,

                  )

            ],
          )

        ),
      ),
    );
  }

  List<String> _getSteps(AppLocalizations local) {
    switch (order.status) {
      case OrderStatus.Pending:
      case OrderStatus.Accepted:
      case OrderStatus.Paid:
      case OrderStatus.Waiting:
        return [local.pending, local.accepted, local.paidPending];
      case OrderStatus.InProgress:
        return [local.orderCreated, local.paymentConfirmed, local.workStarted, local.inProgress];
      case OrderStatus.Completed:
        return [local.orderCreated, local.paymentConfirmed, local.workStarted, local.delivery, local.completed];
      case OrderStatus.Cancelled:
        return [local.orderCreated, local.cancelled];
    }
  }
}
