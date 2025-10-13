import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taskly_admin/core/components/confirmation_dialog.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/update_order_status_view_model/update_order_status_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/update_payment_status_view_model/update_payment_status_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/payment_proof_bottom_sheet_content.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import '../../manager/update_payment_status_view_model/update_payment_status_view_model_states.dart';

class CustomPaymentStatusCard extends StatelessWidget {
  final PaymentEntity payment;
  final bool isFreelancer;
  const CustomPaymentStatusCard({
    super.key,
    required this.payment,
    required this.isFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;


    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UpdatePaymentStatusViewModel>()),
      ],
      child: GestureDetector(
        onLongPress: () {
          showConfirmationDialog(
            context: context,
            title: local.confirm_delete,
            message: local.delete_confirmation_message,
            onConfirm: () {


            },
            onCancel: () {
              print("Deletion cancelled");
            },
          );
        },

        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: ColorsManager.primary.withOpacity(0.2)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTransactionHeader(context, isFreelancer),
                SizedBox(height: 12.h),
                _buildDateInfo(context),
                SizedBox(height: 16.h),
                _buildActionButtons(context, isFreelancer),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionHeader(BuildContext context, bool isFreelancer) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(),
        SizedBox(width: 12.w),
        _buildTransactionDetails(context, isFreelancer),
        _buildAmount(context),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorsManager.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        FontAwesomeIcons.creditCard,
        color: ColorsManager.primary,
        size: 20.sp,
      ),
    );
  }

  Widget _buildTransactionDetails(BuildContext context, bool isFreelancer) {
    final local = AppLocalizations.of(context)!;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider(
            create: (context) => getIt<GetUserInfoByIdViewModel>()
              ..getUserInfoById(
                  isFreelancer ? payment.freelancerId! : payment.clientId!),
            child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
              builder: (context, state) {
                if (state is GetUserInfoByIdSuccess) {
                  return Text(
                    state.userEntity.fullName!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: ColorsManager.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Shimmer(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade100],
                  ),
                  child: Container(
                    width: 120.w,
                    height: 16.h,
                    color: Colors.grey.shade300,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 6.h),
          isFreelancer
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${local.accountNumber}: ${payment.accountNumber}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "${local.paymentMethod}: ${payment.paymentMethod}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          )
              : Text(
            "${local.orderId}: #${payment.orderId}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmount(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        "${payment.amount}\$",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 13.sp,
          color: Colors.green[700],
        ),
      ),
    );
  }

  Widget _buildDateInfo(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey[600]),
            SizedBox(width: 6.w),
            Text(
              DateFormat('EEE, d MMM yyyy HH:mm a').format(payment.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isFreelancer) {
    final local = AppLocalizations.of(context)!;
    final viewButton = Expanded(
      child: _ActionButton(
        label: local.viewDetails ,
        icon: Icons.visibility,
        textColor: ColorsManager.primary,
        backgroundColor: Colors.white,
        borderColor: ColorsManager.primary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return PaymentProofBottomSheetContent(
                paymentEntity: payment,
                isFreelancer: isFreelancer,
              );
            },
          );
        },
      ),
    );

    if (payment.status.toLowerCase() == "pending") {
      return Row(
        children: [
          viewButton,
          SizedBox(width: 8.w),
          Expanded(
            child: BlocBuilder<UpdatePaymentStatusViewModel,
                UpdatePaymentStatusViewModelStates>(
              builder: (context, state) {
                final isLoading = state is UpdatePaymentStatusViewModelStatesLoading;
                return _ActionButton(
                  label: isLoading ? local.loading : local.accepted,
                  icon: isLoading ? Icons.hourglass_top : Icons.check_circle,
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                  onPressed: isLoading
                      ? null
                      : () {
                    if (payment.requesterType == "client") {
                      getIt<UpdateOrderStatusViewModel>()
                          .updateOrderStatus(payment.orderId!, "In Progress");
                    }

                    getIt<UpdatePaymentStatusViewModel>().updatePaymentStatus(
                      paymentId: payment.id,
                      status: "Approved",
                      freelancerId: payment.freelancerId ?? "",
                      amount: payment.amount,

                    );
                  },
                );
              },
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: BlocBuilder<UpdatePaymentStatusViewModel,
                UpdatePaymentStatusViewModelStates>(
              builder: (context, state) {
                final isLoading = state is UpdatePaymentStatusViewModelStatesLoading;
                return _ActionButton(
                  label: isLoading ?local.loading :local.rejected,
                  icon: isLoading ? Icons.hourglass_top : Icons.cancel,
                  textColor: Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: isLoading
                      ? null
                      : () {
                    getIt<UpdatePaymentStatusViewModel>().updatePaymentStatus(
                      paymentId: payment.id,
                      status: "Rejected",
                      freelancerId: payment.freelancerId ?? "",
                      amount: 0,

                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    } else {
      final isApproved = payment.status.toLowerCase() == "approved";

      return Row(
        children: [
          viewButton,
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isApproved
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                border: Border.all(
                  color: isApproved ? Colors.green : Colors.red,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isApproved ? Icons.check_circle : Icons.cancel,
                    color: isApproved ? Colors.green : Colors.red,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    isApproved ? local.accepted : local.rejected,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: isApproved ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
        ),
      ),
      icon: Icon(icon, size: 16.sp, color: textColor),
      label: Text(label, style: TextStyle(fontSize: 12.sp, color: textColor)),
    );
  }
}
