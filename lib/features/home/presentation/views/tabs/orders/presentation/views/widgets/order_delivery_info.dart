import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class OrderDeliveryInfo extends StatelessWidget {
  final String date;

  const OrderDeliveryInfo({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 18.sp, color: ColorsManager.primary),
        SizedBox(width: 6.w),
        Text(
          "${local.delivery}: $date",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
