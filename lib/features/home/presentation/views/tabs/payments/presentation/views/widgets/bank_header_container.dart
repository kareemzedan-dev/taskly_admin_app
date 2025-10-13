import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class BankHeaderContainer extends StatelessWidget {
  final String title;
  final String iconAsset;
  final VoidCallback? onTap;

  const BankHeaderContainer({
    super.key,
    required this.title,
    required this.iconAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: ColorsManager.primary,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.secondary,
              ),
              padding: EdgeInsets.all(8.w),
              child: Image.asset(
                iconAsset,
                height: 20.h,
                width: 20.w,
                color: ColorsManager.primary,
              ),
            ),
            SizedBox(width: 12.w),


            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontSize: 16.sp),
              ),
            ),

            SizedBox(width: 8.w),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
