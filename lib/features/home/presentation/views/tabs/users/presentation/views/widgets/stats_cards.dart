
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_order_by_id_view_model/get_order_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/user_status_card.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class StatsCards extends StatelessWidget {
  final GetOrderByIdSuccessState state;
  final UserEntity user;

  const StatsCards({super.key, required this.state, required this.user});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserStatusCard(
              title: local.totalOrders,
              value: user.totalOrders.toString(),
              icon: Icons.shopping_cart,
              color: Colors.blue,
            ),
            SizedBox(width: 16.w),
            UserStatusCard(
              title: local.completed,
              value: user.completedOrders.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserStatusCard(
              title: local.earnings,
              value: "\$${user.totalEarnings} ${local.sar}",
              icon: Icons.attach_money,
              color: Colors.orange,
            ),
            SizedBox(width: 16.w),
            UserStatusCard(
              title: local.rating,
              value: user.rating?.toStringAsFixed(1) ?? "0.0",
              icon: Icons.star,
              color: Colors.amber,
            ),
          ],
        ),
      ],
    );
  }
}
