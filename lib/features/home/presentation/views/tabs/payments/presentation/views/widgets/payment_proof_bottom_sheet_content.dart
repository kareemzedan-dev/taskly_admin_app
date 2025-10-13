import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/attachment_section.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_header.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_user_info_shimmer.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class PaymentProofBottomSheetContent extends StatelessWidget {
  const PaymentProofBottomSheetContent({
    super.key,
    required this.paymentEntity,
    required this.isFreelancer,
  });

  final PaymentEntity paymentEntity;
  final bool isFreelancer;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               local.paymentDetails,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),

          Expanded(
            child: SingleChildScrollView(
              child: isFreelancer
                  ? _buildFreelancerView(context)
                  : _buildClientView(context),
            ),
          ),
        ],
      ),
    );
  }

  // ===================== Freelancer View =====================
  Widget _buildFreelancerView(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                   _buildInfoItem(local.paymentID, paymentEntity.id),
        _buildInfoItem(local.freelancerID, paymentEntity.freelancerId),
 
           _buildInfoItem( local.paymentMethod, paymentEntity.paymentMethod),
              _buildInfoItem( local.accountNumber, paymentEntity.accountNumber),
                   SizedBox(height: 10.h),
                   Divider(thickness: 1, color: Colors.grey),
   
        SizedBox(height: 10.h),
        Text( local.freelancerInfo, style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        )),

        BlocProvider(
          create: (context) => getIt<GetUserInfoByIdViewModel>()
            ..getUserInfoById(paymentEntity.freelancerId!),
          child:
              BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
            builder: (context, state) {
              if (state is GetUserInfoByIdSuccess) {
                return ListTile(
                  leading: UserAvatar(
                    imagePath: state.userEntity.profileImage,
                    radius: 25.r,
                  ),
                  title: Text(state.userEntity.fullName ?? "Unknown"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${local.balance}: \$${state.userEntity.freelancerBalance ?? 0} ${local.sar}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        "${local.requestedWithdraw} \$${paymentEntity.amount} ${local.sar}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const OrderUserInfoShimmer();
            },
          ),
        ),
      ],
    );
  }
// ===================== Client View =====================
Widget _buildClientView(BuildContext context) {
    final local = AppLocalizations.of(context)!;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Order Info
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderHeader(
            orderName:local.orderId,
            orderId: paymentEntity.orderId ?? '',
          ),
          Chip(
            backgroundColor: Colors.green.shade100,
            label: Text(
              "\$${paymentEntity.amount} ${local.sar}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.green.shade800),
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),

      // ✅ Client ID
      _buildInfoItem( local.clientID, paymentEntity.clientId),

      // ✅ Freelancer ID
      _buildInfoItem( local.freelancerID, paymentEntity.freelancerId),

      SizedBox(height: 16.h),

      // Client Info
      Text(
      local.client,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      SizedBox(height: 4.h),
      BlocProvider(
        create: (context) => getIt<GetUserInfoByIdViewModel>()
          ..getUserInfoById(paymentEntity.clientId!),
        child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
          builder: (context, state) {
            if (state is GetUserInfoByIdSuccess) {
              return ListTile(
                leading: UserAvatar(
                  imagePath: state.userEntity.profileImage,
                  radius: 20.r,
                ),
                title: Text(state.userEntity.fullName ?? "Unknown"),
                subtitle: Text(state.userEntity.email ?? ""),
              );
            }
            return const OrderUserInfoShimmer();
          },
        ),
      ),

      SizedBox(height: 20.h),

      // ✅ Freelancer Info
      Text(
       local.freelancer,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      SizedBox(height: 4.h),
      BlocProvider(
        create: (context) => getIt<GetUserInfoByIdViewModel>()
          ..getUserInfoById(paymentEntity.freelancerId!),
        child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
          builder: (context, state) {
            if (state is GetUserInfoByIdSuccess) {
              return ListTile(
                leading: UserAvatar(
                  imagePath: state.userEntity.profileImage,
                  radius: 20.r,
                ),
                title: Text(state.userEntity.fullName ?? "Unknown"),
                subtitle: Text(state.userEntity.email ?? ""),
              );
            }
            return const OrderUserInfoShimmer();
          },
        ),
      ),

      SizedBox(height: 20.h),

      // Receipt
      Text(
       local.bankTransferReceipt,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      SizedBox(height: 10.h),
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AttachmentsSection(
              attachmentEntity: paymentEntity.attachments,
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildInfoItem(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
