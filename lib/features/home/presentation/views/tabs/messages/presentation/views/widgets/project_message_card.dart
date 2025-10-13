import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_client_info.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_user_info_shimmer.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class ProjectCard extends StatelessWidget {
  final OrderEntity orderEntity;
  final VoidCallback onTap;
  final String status;
  final Color statusColor;
 
  ProjectCard({
    super.key,
    required this.onTap,
    required this.orderEntity,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsManager.primary.withOpacity(.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 6.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Title + Order ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderEntity.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                        overflow: TextOverflow.ellipsis, // ✅ علشان النص الطويل
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${local.orderId}: ${orderEntity.id}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Status
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    orderEntity.status.name,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            BlocProvider(
              create:
                  (context) =>
                      getIt<GetUserInfoByIdViewModel>()
                        ..getUserInfoById(orderEntity.clientId),
              child:
                  BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
                    builder: (context, state) {
                      if (state is GetUserInfoByIdLoading) {
                        return const OrderUserInfoShimmer();
                      }
                      if (state is GetUserInfoByIdSuccess) {
               
                        return OrderUserInfo(
                          userEntity: UserEntity(
                            id: state.userEntity.id,
                            profileImage: state.userEntity.profileImage,
                            fullName: state.userEntity.fullName,
                            rating: state.userEntity.rating,
                            email: state.userEntity.email,
                            role: local.client,
                            totalOrders: state.userEntity.totalOrders,
                            totalEarnings: state.userEntity.totalEarnings,
                            completedOrders: state.userEntity.completedOrders,
                          ),
                        );
                      }
                      return const OrderUserInfoShimmer();
                    },
                  ),
            ),

            Divider(height: 20.h),

            /// -------- Freelancer Info --------
            BlocProvider(
              create:
                  (context) =>
                      getIt<GetUserInfoByIdViewModel>()
                        ..getUserInfoById(orderEntity.freelancerId!),
              child:
                  BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
                    builder: (context, state) {
                      if (state is GetUserInfoByIdLoading) {
                        return const OrderUserInfoShimmer();
                      }
                      if (state is GetUserInfoByIdSuccess) {
                        return OrderUserInfo(
                          userEntity: UserEntity(
                            id: state.userEntity.id,
                            profileImage: state.userEntity.profileImage,
                            fullName: state.userEntity.fullName,
                            rating: state.userEntity.rating,
                            email: state.userEntity.email,
                            role: local.freelancer,
                            totalOrders: state.userEntity.totalOrders,
                            totalEarnings: state.userEntity.totalEarnings,
                            completedOrders: state.userEntity.completedOrders,
                          ),
                        );
                      }
                      return const OrderUserInfoShimmer();
                    },
                  ),
            ),
            SizedBox(height: 8.h),

            /// Deadline
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    "${local.deadline}: ${DateFormat('EEE, d MMM yyyy').format(orderEntity.deadline!)}",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            /// Budget
            if (orderEntity.budget != null)
              Text(
                "${local.budget}: ${orderEntity.budget} \$",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
