import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/core/utils/mappers.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/filters_view_model/filters_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_all_users_view_model/get_all_users_view_model.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

// ------------------ FilterBottomSheetContent ------------------
class FilterBottomSheetContent extends StatelessWidget {
  const FilterBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final sortOptions = [
      local.highestRating,
      local.mostEarnings,
      local.mostCompleted,
      local.newest,
      local.oldest,
    ];

    final statuses = [
      {"label": local.all, "color": Colors.grey},
      {"label": local.active, "color": Colors.green},
      {"label": local.suspended, "color": Colors.orange},
      {"label": local.pending, "color": Colors.blue},
      {"label": local.inactive, "color": Colors.red},
    ];

    return BlocBuilder<FilterViewModel, FilterState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ---- Header ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.filterBy,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<FilterViewModel>().clearFilters(local.all);
                      context.read<GetAllUsersViewModel>().clearFilters();
                    },
                    child: Text(
                      local.clearAll,
                      style: TextStyle(
                        color: ColorsManager.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// ---- Status Chips ----
              StatusFilterChips(
                statuses: statuses,
                selectedStatus: state.selectedStatus,
                onSelected: (status) =>
                    context.read<FilterViewModel>().selectStatus(status),
              ),
              SizedBox(height: 16.h),

              /// ---- Sort Chips ----
              SortByChips(
                sortOptions: sortOptions,
                selectedSort: state.selectedSort,
                onSelected: (sort) =>
                    context.read<FilterViewModel>().selectSort(sort),
              ),

              SizedBox(height: 24.h),
              CustomButton(
                title: local.apply,
                ontap: () {
                  final filterVM = context.read<FilterViewModel>();
                  final userVM = context.read<GetAllUsersViewModel>();

                  // ---- Mapping Strings -> Enums ----
                  if (filterVM.state.selectedStatus != null) {
                    final status =
                        mapStringToStatus(filterVM.state.selectedStatus!);
                    userVM.updateStatus(status);
                  }
                  if (filterVM.state.selectedSort != null) {
                    final sort = mapStringToSort(filterVM.state.selectedSort!);
                    userVM.updateSort(sort);
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ------------------ Chips Widgets ------------------
class SortByChips extends StatelessWidget {
  final List<String> sortOptions;
  final String? selectedSort;
  final Function(String) onSelected;

  const SortByChips({
    super.key,
    required this.sortOptions,
    required this.selectedSort,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: sortOptions.map((option) {
        final isSelected = selectedSort == option;
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (val) {
            if (val) onSelected(option);
          },
          selectedColor: ColorsManager.primary.withOpacity(0.2),
          labelStyle: TextStyle(
            color: isSelected ? ColorsManager.primary : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: isSelected ? ColorsManager.primary : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class StatusFilterChips extends StatelessWidget {
  final List<Map<String, dynamic>> statuses;
  final String? selectedStatus;
  final Function(String) onSelected;

  const StatusFilterChips({
    super.key,
    required this.statuses,
    required this.selectedStatus,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: statuses.map((status) {
        final isSelected = selectedStatus == status["label"];
        final Color color = status["color"] as Color;

        return FilterChip(
          label: Text(status["label"]),
          selected: isSelected,
          onSelected: (val) {
            if (val) onSelected(status["label"]);
          },
          selectedColor: color.withOpacity(0.2),
          checkmarkColor: color,
          labelStyle: TextStyle(
            color: isSelected ? color : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: isSelected ? color : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
        );
      }).toList(),
    );
  }
}
