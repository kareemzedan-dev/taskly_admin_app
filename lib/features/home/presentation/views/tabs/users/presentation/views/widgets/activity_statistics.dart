import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_order_by_id_view_model/get_order_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_order_by_id_view_model/get_order_by_id_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/stats_cards.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
class ActivityStatistics extends StatelessWidget {
  final UserEntity user;
  final bool isFreelancer;

  const ActivityStatistics({super.key, required this.user, required this.isFreelancer});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.activityStatistics,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),

        StatsCards(
          totalOrders: (user.totalOrders ?? 0).toInt(),
          completedOrders: (user.completedOrders ?? 0).toInt(),
          totalEarnings: user.totalEarnings ?? 0 ,
          user: user,
        ),

      ],
    );
  }
}
