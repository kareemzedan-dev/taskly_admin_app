import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_orders_view_model/subscribe_to_orders_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_header.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_progress_time_line.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/user_info_loader.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../order_details_view.dart';
import 'order_delivery_info.dart';

class OrderProgressCard extends StatefulWidget {
  const OrderProgressCard({super.key, required this.order});
  final OrderEntity order;

  @override
  State<OrderProgressCard> createState() => _OrderProgressCardState();
}

class _OrderProgressCardState extends State<OrderProgressCard> {
  UserEntity? client;
  UserEntity? freelancer;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final steps = _getSteps(local, widget.order.status);
    final isLate = DateTime.now().isAfter(widget.order.deadline!);
    final isCompleted = widget.order.status == OrderStatus.Completed;
    final isCancelled = widget.order.status.name == OrderStatus.Cancelled.name;

    Color cardColor;
    BoxBorder? border;

    if (isCompleted) {
      cardColor = Colors.green.withOpacity(0.08);
      border = Border.all(color: Colors.green, width: 1.5);
    } else if (isCancelled) {
      cardColor = Colors.red.withOpacity(0.08);
      border = Border.all(color: Colors.red, width: 1.5);
    } else if (isLate) {
      cardColor = Colors.orange.withOpacity(0.08);
      border = Border.all(color: Colors.orange, width: 1.5);
    } else {
      cardColor = Colors.white;
      border = null;
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: border,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -------- Client Info --------
                  UserInfoLoader(
                    userId: widget.order.clientId,
                    roleLabel: local.client,
                    onLoaded: (user) => client = user,
                  ),

                  Divider(height: 20.h),

                  /// -------- Freelancer Info --------
                  if (widget.order.freelancerId != null)
                    UserInfoLoader(
                      userId: widget.order.freelancerId!,
                      roleLabel: local.freelancer,
                      onLoaded: (user) => freelancer = user,
                    ),

                  SizedBox(height: 12.h),

                  OrderHeader(
                    orderName: widget.order.title,
                    orderId: widget.order.id,
                  ),

                  SizedBox(height: 8.h),

                  if (steps.isNotEmpty)
                    OrderProgressTimeline(
                      steps: steps,
                      currentStep: getIt<SubscribeToOrdersViewModel>()
                          .getTimelineStep(widget.order.status),
                    ),

                  SizedBox(height: 8.h),

                  /// -------- موعد التسليم --------
                  if (!isCompleted && !isCancelled)
                    OrderDeliveryInfo(
                      date: DateFormat('dd MMM yyyy, hh:mm a')
                          .format(widget.order.deadline!),
                    ),

                  SizedBox(height: 8.h),

                  /// -------- زر عرض التفاصيل --------
                  CustomButton(
                    title: local.viewDetails,
                    ontap: () {
                      if (client != null && freelancer != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsView(
                              order: widget.order,
                              client: client!,
                              freelancer: freelancer!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(local.loadingUserInfo)),
                        );
                      }
                    },
                  ),


                ],
              ),
            ),

            /// 🔴 Late label
            if (isLate && !isCompleted && !isCancelled)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    local.late,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),

            /// ✅ Completed
            if (isCompleted)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),

            /// ❌ Cancelled
            if (isCancelled)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<String> _getSteps(AppLocalizations local, OrderStatus status) {
    switch (status) {
      case OrderStatus.InProgress:
        return [local.created, local.paid, local.inProgress];
      default:
        return [];
    }
  }
}
