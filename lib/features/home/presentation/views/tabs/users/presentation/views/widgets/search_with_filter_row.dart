import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/components/custom_search_text_field.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_all_users_view_model/get_all_users_view_model.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
class SearchWithFilterRow extends StatelessWidget {
  final List<String> hintTexts;
  final void Function(int index, String value) onChanged;
  final VoidCallback onFilterTap;

  const SearchWithFilterRow({
    super.key,
    required this.hintTexts,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(hintTexts.length, (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CustomSearchTextField(
                    hintTexts: [hintTexts[index]],
                    onChanged: (value) => onChanged(index, value),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorsManager.primary, width: 2),
          ),
          child: IconButton(
            onPressed: onFilterTap,
            icon: const Icon(
              Icons.filter_list_rounded,
              color: ColorsManager.primary,
              size: 30,
            ),
            tooltip: local.filters,
          ),
        ),
      ],
    );
  }
}
