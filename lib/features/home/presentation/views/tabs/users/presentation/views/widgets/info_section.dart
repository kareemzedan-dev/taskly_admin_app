import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/info_row.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';


class InfoSection extends StatelessWidget {
  final UserEntity user;

  const InfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        InfoRow(
          icon: Icons.phone,
          label: local.phone,
          value: (user.phoneNumber?.isNotEmpty ?? false)
              ? user.phoneNumber!
              :  local.notAvailable,
        ),
        SizedBox(height: 10.h),
        InfoRow(
          icon: Icons.date_range,
          label: local.registrationDate,
          value: DateFormat('EEE, d MMM yyyy HH:mm').format(user.createdAt!),
        ),
        SizedBox(height: 10.h),
        InfoRow(
          icon: Icons.update,
          label: local.lastUpdated,
          value: DateFormat('EEE, d MMM yyyy HH:mm')
              .format(user.updatedAt ?? user.createdAt!),
        ),
      ],
    );
  }
}
