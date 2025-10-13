import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/payments_view_model/payments_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/subscribe_payments_view_model/subscribe_payments_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/payment_tab_view_body.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class PaymentTabView extends StatelessWidget {
  const PaymentTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar:   CustomAppBar(
        title:local.managePayments,
        image: Assets.assetsImagesMoney10894489,
      ),
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<PaymentsViewModel>()),
          BlocProvider(create: (_) => getIt<SubscribePaymentsViewModel>()),
        ],
        child: const PaymentTabViewBody(),
      ),
    );
  }
}
