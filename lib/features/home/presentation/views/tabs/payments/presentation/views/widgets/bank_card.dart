import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/update_bank_account_status_view_model/update_bank_account_status_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/bank_account_details_view.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../manager/update_bank_account_status_view_model/update_bank_account_status_states.dart';
import 'mini_account_detail.dart';

class BankCard extends StatelessWidget {
  final BankAccountsEntity account;

  const BankCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateBankAccountStatusViewModel>();
    cubit.setInitialStatus(account.id!, account.isActive!);
    final local = AppLocalizations.of(context)!;

    return Card(
      elevation: 6,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.primary.withValues(alpha: .5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              BlocBuilder<UpdateBankAccountStatusViewModel, UpdateBankAccountStatusStates>(
                builder: (context, state) {
                  final isActive = cubit.accountsStatus[account.id!] ?? account.isActive!;
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.primary.withValues(alpha: .2),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(FontAwesomeIcons.buildingColumns),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.bankName ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            account.accountName ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.green.withOpacity(.1)
                              : Colors.red.withOpacity(.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            isActive ? local.active :local.inactive,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isActive ? Colors.green : Colors.red,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  MiniAccountDetail(
                    title: local.accountNumber,
                    value: account.accountNumber ?? "N/A",
                    icon: Icons.account_balance,
                  ),
                  MiniAccountDetail(
                    title: local.iban,
                    value: account.iban ?? "N/A",
                    icon: Icons.credit_card,
                  ),
                  MiniAccountDetail(
                    title:local.swiftCode,
                    value: account.swiftCode ?? "N/A",
                    icon: Icons.swap_horiz,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (account.notes != null && account.notes!.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey.withOpacity(.1),
                  ),
                  child: Text("${local.notes}: ${account.notes}"),
                ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BankAccountDetailsView(
                        bankAccountsEntity: account,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                    border: Border.all(
                      color: ColorsManager.primary,
                      width: 2.w,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.penToSquare, color: ColorsManager.primary),
                        SizedBox(width: 6.w),
                        Text(
                          local.edit,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: ColorsManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<UpdateBankAccountStatusViewModel, UpdateBankAccountStatusStates>(
                builder: (context, state) {
                  final isActive = cubit.accountsStatus[account.id!] ?? account.isActive!;
                  final isLoading = state is UpdateBankAccountStatusLoading && state.id == account.id!;

                  return GestureDetector(
                    onTap: isLoading ? null : () {
                      cubit.updateStatus(account.id!);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        border: Border.all(color: Colors.red, width: 2.w),
                      ),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.red)
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.ban, color: Colors.red),
                            SizedBox(width: 6),
                            Text(
                              isActive ? local.deactivateAccount :  local.activateAccount,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
