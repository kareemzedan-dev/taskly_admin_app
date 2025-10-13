import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/core/components/dismissible_error_card.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/update_order_status_view_model/update_order_status_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/description_section.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../../../../../core/components/confirmation_dialog.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../../../messages/presentation/views/widgets/custom_states_container.dart';
import '../../manager/update_order_status_view_model/update_order_status_view_model.dart';
import 'client_details.dart';
import 'order_header.dart';
import 'order_time_line_section.dart';

class OrderDetailsViewBody extends StatelessWidget {
  const OrderDetailsViewBody({
    super.key,
    required this.order,
    required this.client,
    required this.freelancer,
  });

  final OrderEntity order;
  final UserEntity client;
  final UserEntity freelancer;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final bool isCancelled = order.status == OrderStatus.Cancelled;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---------- Header ----------
          _OrderHeaderSection(order: order),

          SizedBox(height: 20.h),

          /// ---------- Budget ----------
          _OrderBudgetBox(budget: order.budget!),

          SizedBox(height: 20.h),

          /// ---------- Client Info ----------
          UserDetailsSection(
            title: local.clientDetails,
           isFreelancer: false,
            userEntity: client,
          ),

          SizedBox(height: 20.h),

          /// ---------- Freelancer Info ----------
          UserDetailsSection(
            title: local.freelancerDetails,
            isFreelancer: true,
            userEntity: freelancer,

          ),

          SizedBox(height: 10.h),
          const _DividerSection(),
          SizedBox(height: 10.h),

          /// ---------- Description ----------
          DescriptionSection(description: order.description ?? local.noDescription),

          SizedBox(height: 10.h),
          const _DividerSection(),
          SizedBox(height: 10.h),

          /// ---------- Timeline ----------
          _OrderTimelineTitle(local: local),
          SizedBox(height: 10.h),
          OrderTimelineSection(
            order: order,


          ),

          SizedBox(height: 20.h),

          /// ---------- Cancel Button ----------
          if (!isCancelled)
         BlocBuilder<UpdateOrderStatusViewModel, UpdateOrderStatusStates>(builder: (context, state) {
           if(state is UpdateOrderStatusLoading){
             return const Center(child: CircularProgressIndicator());
           }
           if(state is UpdateOrderStatusSuccess){
             Navigator.pop(context);

           }
           if(state is UpdateOrderStatusError){
             showTemporaryMessage(context, "Something went wrong, try again later", MessageType.error);
           }
           return     _CancelOrderButton(local: local,

             onTap: () {
               showConfirmationDialog(context: context, title: local.cancelOrder, message: "Are you sure you want to cancel this order?", onConfirm: () {
                 context.read<UpdateOrderStatusViewModel>().updateOrderStatus(order.id, OrderStatus.Cancelled.name);
               });

             },
           );

         },),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

/// ---------------- HEADER SECTION ----------------
class _OrderHeaderSection extends StatelessWidget {
  const _OrderHeaderSection({required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: OrderHeader(
            orderName: order.title,
            orderId: order.id,
          ),
        ),
        SizedBox(width: 8.w),
        CustomStatesContainer(state: order.status.name),
      ],
    );
  }
}

/// ---------------- BUDGET BOX ----------------
class _OrderBudgetBox extends StatelessWidget {
  final double budget;
  const _OrderBudgetBox({required this.budget});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.green.shade50,
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.attach_money, color: Colors.green, size: 20.sp),
            SizedBox(width: 4.w),
            Text(
              budget.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- CANCEL BUTTON ----------------
class _CancelOrderButton extends StatelessWidget {
  const _CancelOrderButton({required this.local, required this.onTap});
  final AppLocalizations local;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.red, width: 2.w),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.circleXmark, color: Colors.red),
              SizedBox(width: 6.w),
              Text(
                local.cancelOrder,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- DIVIDER ----------------
class _DividerSection extends StatelessWidget {
  const _DividerSection();
  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1.w, color: Colors.grey.shade300);
  }
}

/// ---------------- TIMELINE TITLE ----------------
class _OrderTimelineTitle extends StatelessWidget {
  const _OrderTimelineTitle({required this.local});
  final AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Text(
      local.orderTimeline,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: Colors.black87,
      ),
    );
  }
}
