import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/add_bank_acount_view_model/add_bank_acount_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/delete_bank_account_view_model/delete_bank_account_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/update_bank_account_view_model/update_bank_account_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/bank_account_details_view_body.dart';

import '../../../../../../../../l10n/app_localizations.dart';
class BankAccountDetailsView extends StatelessWidget {
  const BankAccountDetailsView({super.key, this.bankAccountsEntity});
  final BankAccountsEntity? bankAccountsEntity;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: bankAccountsEntity != null ? local.editBankAccount: local.addBankAccount,
        isLeading: true,
      ),
      body: bankAccountsEntity != null
          ? BlocProvider(
              create: (_) => getIt<UpdateBankAccountViewModel>(),
              child: BankAccountDetailsViewBody(
                bankAccountsEntity: bankAccountsEntity,
                isEdit: true,
              ),
            )
          : BlocProvider(
              create: (_) => getIt<AddBankAccountViewModel>(),
              child: BankAccountDetailsViewBody(
                isEdit: false,
              ),
            ),
    );
  }
}
