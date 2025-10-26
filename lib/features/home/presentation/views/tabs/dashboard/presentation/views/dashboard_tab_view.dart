import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/admin_setting_drawer.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../../core/utils/colors_manger.dart';
import '../../../payments/presentation/manager/payments_view_model/payments_view_model.dart';
import '../manager/get_all_orders_view_model/get_all_orders_view_model.dart';
import '../../../users/presentation/manager/get_all_users_view_model/get_all_users_view_model.dart';
import '../manager/late_orders_view_model/late_orders_view_model.dart';
import '../manager/pending_payments_view_model/pending_payments_view_model.dart';
import '../manager/pending_verifications_view_case/pending_verifications_view_model.dart';
import '../widgets/dashboard_tab_view_body.dart';

class DashboardTabView extends StatelessWidget {
  DashboardTabView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _onRefresh(BuildContext context) async {
    // نعيد تحميل كل البيانات
    context.read<GetAllOrdersViewModel>().getAllOrders();
    context.read<GetAllUsersViewModel>().getAllUsers();
    context.read<PendingVerificationsViewModel>().getPendingVerifications();
    context.read<PendingPaymentsViewModel>().getPendingPayments();
    context.read<LateOrdersViewModel>().getLateOrders();

    // نديه delay بسيط علشان الـ indicator يبين شويه
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: local.manageDashboard,
        image: Assets.assetsImagesDashboard,
        menuIconShow: true,
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const AdminSettingsDrawer(),
      backgroundColor: ColorsManager.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<GetAllOrdersViewModel>()..getAllOrders(),
          ),
          BlocProvider(
            create: (_) => getIt<GetAllUsersViewModel>()..getAllUsers(),
          ),
          BlocProvider(
            create: (_) => getIt<PendingVerificationsViewModel>()
              ..getPendingVerifications(),
          ),
          BlocProvider(
            create: (_) =>
            getIt<PendingPaymentsViewModel>()..getPendingPayments(),
          ),
          BlocProvider(
            create: (_) => getIt<LateOrdersViewModel>()..getLateOrders(),
          ),
        ],
        child: Builder(
          builder: (context) => RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: const DashboardTabViewBody(),
          ),
        ),
      ),
    );
  }
}
