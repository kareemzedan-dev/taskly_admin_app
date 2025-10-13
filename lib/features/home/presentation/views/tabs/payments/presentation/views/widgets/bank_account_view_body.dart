import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/components/custom_search_text_field.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/get_bank_account_view_model/get_bank_account_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/get_bank_account_view_model/get_bank_account_view_model_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/bank_accounts_list.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/bank_card_shimmer.dart';

import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../l10n/app_localizations.dart';

class BankAccountViewBody extends StatelessWidget {
  const BankAccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => getIt<GetBankAccountViewModel>()..fetchBankAccounts(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchTextField(hintTexts: [local.searchBankAccount]),
            SizedBox(height: 16.h),

            Expanded(
              child: BlocBuilder<
                GetBankAccountViewModel,
                GetBankAccountViewModelStates
              >(
                builder: (context, state) {
                  if (state is GetBankAccountViewModelStatesLoading) {
                    return ListView.separated(
                      itemCount: 3,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) => const BankCardShimmer(),
                    );
                  } else if (state is GetBankAccountViewModelStatesLoading) {
                    return ListView.separated(
                      itemCount: 3,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) => const BankCardShimmer(),
                    );
                  } else if (state is GetBankAccountViewModelStatesSuccess) {
                    return BankAccountsList(accounts: state.bankAccounts);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            SizedBox(height: 16.h),

            CustomButton(
              title: local.addBankAccount,
              ontap: () {
                Navigator.pushNamed(
                  context,
                  RoutesManager.bankAccountDetailsView,
                  arguments: "Add New Bank Account",
                );
              },
              icon: FontAwesomeIcons.plus,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
