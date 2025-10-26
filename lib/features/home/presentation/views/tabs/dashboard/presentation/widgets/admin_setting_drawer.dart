import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/strings_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/add_commission_view_model/add_commission_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/add_commission_view_model/add_commission_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/language_bottom_sheet_content.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/widgets/theme_bottom_sheet_content.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';

class AdminSettingsDrawer extends StatelessWidget {
  const AdminSettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final adminId = SharedPrefHelper.getString(StringsManager.idKey);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: ColorsManager.primary),
            child: Center(
              child: Text(
                local.manageDashboard,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorsManager.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.color_lens),
          //   title: Text(local.theme),
          //   onTap: () {
          //     Navigator.pop(context);
          //     showBottomSheet(
          //       context: context,
          //       builder: (context) => ThemeBottomSheetContent(),
          //     );
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(local.language),
            onTap: () {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) => LanguageBottomSheetContent(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.percent),
            title: Text(local.commissionPercentage),
            onTap: () {
              Navigator.pop(context);
              showBottomSheet(
                context: context,
                builder: (context) {
                  double currentValue =
                      SharedPrefHelper.getDouble(
                        StringsManager.commissionKey,
                      ) ??
                      0.0;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        padding: EdgeInsets.all(16.sp),
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              local.commissionPercentage,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 16.sp),
                            Slider(
                              min: 0,
                              max: 50,
                              divisions: 50,
                              label: "${currentValue.toInt()}%",
                              value: currentValue,
                              onChanged: (value) {
                                setState(() {
                                  currentValue = value;
                                });
                              },
                            ),
                            BlocProvider(
                              create:
                                  (context) => getIt<AddCommissionViewModel>(),
                              child: BlocConsumer<
                                AddCommissionViewModel,
                                AddCommissionStates
                              >(
                                listener: (context, state) {
                                  if (state is AddCommissionSuccessState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(local.save + " ✅"),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    SharedPrefHelper.setDouble(
                                      StringsManager.commissionKey,
                                      currentValue,
                                    );
                                  } else if (state is AddCommissionErrorState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton(
                                    title:
                                        "${currentValue.toInt()}% ${local.save}",
                                    ontap: () {
                                      final entity = AdminSettingsEntity(
                                        id: Uuid().v4(),
                                        adminId: adminId!,
                                        commission: currentValue,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                      );
                                      context
                                          .read<AddCommissionViewModel>()
                                          .addCommission(entity);
                                    },
                                    isLoading:
                                        state is AddCommissionLoadingState,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
