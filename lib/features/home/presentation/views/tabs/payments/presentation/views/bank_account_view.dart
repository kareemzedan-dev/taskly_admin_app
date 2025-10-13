import 'package:flutter/material.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/bank_account_view_body.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class BankAccountView extends StatelessWidget {
  const BankAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      appBar:   CustomAppBar(title: local.bankAccountManagement, isLeading:  true, ),
      body: BankAccountViewBody(),
    );
  }
}
