
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
class OffersFilters extends StatelessWidget {
  final List<String> filters;
  final String? selectedFilter;
  final Function(String) onFilterSelected;

  const OffersFilters({
    super.key,
    required this.filters,
    this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Row(
      children: [
        Text(
          " ${local.filterBy}",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w),
        ...filters.map(
              (filter) {
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: FilterChip(
                label: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                selected: isSelected,
                backgroundColor: ColorsManager.primary.withOpacity(.5),
                selectedColor: ColorsManager.primary.withOpacity(0.7),
                onSelected: (_) => onFilterSelected(filter),
              ),
            );
          },
        ),
      ],
    );
  }
}
