import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_orders_view_model/subscribe_to_orders_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_tab_view_body.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class OrderTabView extends StatelessWidget {
  const OrderTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      backgroundColor: Colors.white,
    appBar:   CustomAppBar(title:local.manageOrders,image: Assets.assetsImagesDocument10103871, ),
      body: BlocProvider(
  create: (_) => getIt<SubscribeToOrdersViewModel>()..getOrdersRealtime(),
  child: const OrderTabViewBody(),
),

    );
  }
}