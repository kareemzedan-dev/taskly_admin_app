import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/widgets/bank_card.dart';

import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../manager/update_bank_account_status_view_model/update_bank_account_status_view_model.dart';

class BankAccountsList extends StatelessWidget {
  final List<BankAccountsEntity> accounts;
  const BankAccountsList({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (accounts.isEmpty) {
      return   Center(child: Text(local.noAccountsFound,));
    }
    return ListView.separated(
      itemCount: accounts.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return BlocProvider(
            create:  (context) => getIt<UpdateBankAccountStatusViewModel>(),
            child: BankCard(account: accounts[index]));
      },
    );
  }
}
