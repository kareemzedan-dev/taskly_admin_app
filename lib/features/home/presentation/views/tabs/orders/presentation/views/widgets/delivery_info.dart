
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({super.key,required this.deadline});
 final String deadline;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(FontAwesomeIcons.clock, color: Colors.grey.shade400, size: 15.sp),
        SizedBox(width: 5.w),
        Text(
          " ${local.deadline}: $deadline",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        ),
      ],
    );
  }
}

 
 