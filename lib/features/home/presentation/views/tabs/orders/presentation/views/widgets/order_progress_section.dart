import 'package:flutter/material.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../manager/subscribe_to_orders_view_model/subscribe_to_orders_view_model.dart';
import '../../../../../../../../../core/di/di.dart';
import 'order_progress_time_line.dart';

class OrderProgressSection extends StatelessWidget {
  final OrderEntity order;
  final List<String> steps;
  const OrderProgressSection({super.key, required this.order, required this.steps});

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();
    return OrderProgressTimeline(
      steps: steps,
      currentStep: getIt<SubscribeToOrdersViewModel>().getTimelineStep(order.status),
    );
  }
}
