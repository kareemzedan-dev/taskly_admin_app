import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';

class OrderBudgetText extends StatelessWidget {
  final OrderEntity order;
  const OrderBudgetText({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (order.budget == null) return const SizedBox.shrink();
    return Text(
      "${local.budget}: ${order.budget.toString()} SAR",
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),
    );
  }
}
