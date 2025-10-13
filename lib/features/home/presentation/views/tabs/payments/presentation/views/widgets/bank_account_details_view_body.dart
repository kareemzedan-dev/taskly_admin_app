import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/config/routes/routes_manager.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/add_bank_acount_view_model/add_bank_acount_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/add_bank_acount_view_model/add_bank_acount_view_model_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/delete_bank_account_view_model/delete_bank_account_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/delete_bank_account_view_model/delete_bank_account_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/get_bank_account_view_model/get_bank_account_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/update_bank_account_view_model/update_bank_account_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/update_bank_account_view_model/update_bank_account_states.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class BankAccountDetailsViewBody extends StatefulWidget {
  final bool isEdit;
  final BankAccountsEntity? bankAccountsEntity;

  const BankAccountDetailsViewBody({
    super.key,
    this.isEdit = false,
    this.bankAccountsEntity,
  });

  @override
  State<BankAccountDetailsViewBody> createState() =>
      _BankAccountDetailsViewBodyState();
}

class _BankAccountDetailsViewBodyState
    extends State<BankAccountDetailsViewBody> {
  bool isActive = false;

  final bankNameController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ibanController = TextEditingController();
  final swiftCodeController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.bankAccountsEntity != null) {
      final account = widget.bankAccountsEntity!;
      bankNameController.text = account.bankName ?? "";
      accountNameController.text = account.accountName ?? "";
      accountNumberController.text = account.accountNumber ?? "";
      ibanController.text = account.iban ?? "";
      swiftCodeController.text = account.swiftCode ?? "";
      notesController.text = account.notes ?? "";
      isActive = account.isActive ?? false;
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildSwitch() {
    final local = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.activeAccount,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              Text(
                local.enableOrDisableBankAccount,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: isActive,
          onChanged: (val) => setState(() => isActive = val),
          activeColor: Theme.of(context).primaryColor,
          activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.4),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget _buildTextFields() {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(local.basicInformation),
        CustomTextField(
          hintText: local.bankName,
          iconPath: Assets.assetsImagesBankAccount,
          controller: bankNameController,
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          hintText: local.accountName,
          iconPath: Assets.assetsImagesAccountName,
          controller: accountNameController,
        ),
        SizedBox(height: 30.h),
        _buildSectionTitle(local.accountDetails),
        CustomTextField(
          hintText: local.accountNumber,
          iconPath: Assets.assetsImagesPerson,
          controller: accountNumberController,
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          hintText: local.iban,
          iconPath: Assets.assetsImagesMoney,
          controller: ibanController,
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          hintText: local.swiftCode,
          iconPath: Assets.assetsImagesGlobe,
          controller: swiftCodeController,
        ),
        SizedBox(height: 30.h),
        _buildSectionTitle(local.additionalDetails),
        CustomTextField(
          hintText: local.notesOptional,
          iconPath: Assets.assetsImagesDocument10103871,
          controller: notesController,
        ),
        SizedBox(height: 30.h),
        _buildSectionTitle(local.accountSettings),
        _buildSwitch(),
        SizedBox(height: 26.h),
      ],
    );
  }

  Widget _buildActionButtons() {
    final account = BankAccountsEntity(
      id: widget.bankAccountsEntity?.id,
      bankName: bankNameController.text,
      accountName: accountNameController.text,
      accountNumber: accountNumberController.text,
      iban: ibanController.text,
      swiftCode: swiftCodeController.text,
      notes: notesController.text,
      isActive: isActive,
    );

    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        widget.isEdit
            ? BlocProvider(
          create: (_) => getIt<UpdateBankAccountViewModel>(),
          child: BlocConsumer<UpdateBankAccountViewModel, dynamic>(
            listener: (context, state) {
              if (state is UpdateBankAccountSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(local.bankAccountUpdatedSuccessfully),
                  ),
                );
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutesManager.bankAccountView);
              } else if (state is UpdateBankAccountError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return state is UpdateBankAccountLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                title: local.update,
                ontap: () {
                  final account = BankAccountsEntity(
                    id: widget.bankAccountsEntity!.id,
                    bankName: bankNameController.text,
                    accountName: accountNameController.text,
                    accountNumber: accountNumberController.text,
                    iban: ibanController.text,
                    swiftCode: swiftCodeController.text,
                    notes: notesController.text,
                    isActive: isActive,
                  );
                  context.read<UpdateBankAccountViewModel>().updateAccount(account);
                },
              );
            },
          ),
        )
            : BlocConsumer<AddBankAccountViewModel, AddBankAccountStates>(
          listener: (context, state) {
            if (state is AddBankAccountSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(local.bankAccountSavedSuccessfully),
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutesManager.bankAccountView);
            } else if (state is AddBankAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return state is AddBankAccountLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              title: local.save,
              ontap: () {
                final account = BankAccountsEntity(
                  bankName: bankNameController.text,
                  accountName: accountNameController.text,
                  accountNumber: accountNumberController.text,
                  iban: ibanController.text,
                  swiftCode: swiftCodeController.text,
                  notes: notesController.text,
                  isActive: isActive,
                );

                context.read<AddBankAccountViewModel>().addAccount(account);
              },
            );
          },
        ),
        SizedBox(height: 16.h),
        if (widget.isEdit)
          BlocProvider(
            create: (_) => getIt<DeleteBankAccountViewModel>(),
            child: BlocConsumer<DeleteBankAccountViewModel, dynamic>(
              listener: (context, state) {
                if (state is DeleteBankAccountSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(local.bankAccountDeletedSuccessfully),
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesManager.bankAccountView);
                } else if (state is DeleteBankAccountError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: state is DeleteBankAccountLoading
                      ? null
                      : () => context.read<DeleteBankAccountViewModel>().deleteAccount(account.id!),
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 2.w),
                    ),
                    child: Center(
                      child: state is DeleteBankAccountLoading
                          ? const CircularProgressIndicator(color: Colors.red)
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.close, color: Colors.red),
                          SizedBox(width: 6),
                          Text(
                            local.deleteAccount,
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
          ),
        SizedBox(height: 26.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTextFields(), _buildActionButtons()],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? iconPath;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.iconPath,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: controller,
        keyboardType:
        keyboardType == TextInputType.text ? TextInputType.multiline : keyboardType,
        obscureText: obscureText,
        maxLines: null,
        minLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: iconPath != null
              ? Padding(
            padding: EdgeInsets.all(12.w),
            child: Image.asset(
              iconPath!,
              width: 20.w,
              height: 20.w,
              fit: BoxFit.contain,
            ),
          )
              : null,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 12.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
