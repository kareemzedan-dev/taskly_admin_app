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
        BlocBuilder<GetOrdersByIdViewModel, GetOrderByIdStates>(
          builder: (context, state) {
            if (state is GetOrderByIdLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetOrderByIdErrorState) {
              return Center(
                child: Text(
                  state.message.contains("not found") ||
                          state.message.contains("No orders")
                      ? local.noOrdersYet
                      :local.somethingWentWrong,
                ),
              );
            } else if (state is GetOrderByIdSuccessState) {
              if (state.totalOrders == 0) {
                return Center(child: Text(local.noOrdersYet));
              }
              return StatsCards(state: state, user: user);
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
 