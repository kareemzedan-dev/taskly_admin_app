
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
class OrderTimelineSection extends StatelessWidget {
  final OrderEntity order;

  const OrderTimelineSection({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final steps = [
      local.orderCreated,
      local.paymentConfirmed,
      local.workStarted,
      local.completed,
    ];

    final dates = [
      DateFormat('dd/MM/yyyy – HH:mm a').format(order.createdAt),
      order.paymentConfirmedAt != null
          ? DateFormat('dd/MM/yyyy – HH:mm a').format(order.paymentConfirmedAt!)
          : "—",
      order.workStartedAt != null
          ? DateFormat('dd/MM/yyyy – HH:mm a').format(order.workStartedAt!)
          : "—",
      order.completedAt != null
          ? DateFormat('dd/MM/yyyy – HH:mm a').format(order.completedAt!)
          : "—",
    ];


    final currentStep = getStepIndex(order.status);

    return Column(
      children: List.generate(steps.length, (index) {
        final isActive = index <= currentStep;
        return _TimelineItem(
          step: steps[index],
          date: dates[index],
          isActive: isActive,
          isLast: index == steps.length - 1,
        );
      }),
    );
  }
}

int getStepIndex(OrderStatus status) {
  switch (status) {
    case OrderStatus.Pending:
      return 0;
      case OrderStatus.Paid:
        return 1;
    case OrderStatus.InProgress:
      return 2;
    case OrderStatus.Completed:
      return 2;
    case OrderStatus.Cancelled:
      return 0;
    default:
      return 0;
  }
}



class _TimelineItem extends StatelessWidget {
  final String step;
  final String date;
  final bool isActive;
  final bool isLast;

  const _TimelineItem({
    required this.step,
    required this.date,
    required this.isActive,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? ColorsManager.primary : Colors.grey.shade300,
              ),
              child: Icon(
                isActive ? Icons.check : Icons.circle_outlined,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: isActive ? ColorsManager.primary : Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ],
    );
  }
}
