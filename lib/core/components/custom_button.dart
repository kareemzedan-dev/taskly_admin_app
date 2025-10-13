import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? ontap;
  final IconData? icon;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.title,
    required this.ontap,
    this.icon,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.height,
    this.borderRadius,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = color ?? ColorsManager.primary;
    final txtColor = textColor ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isOutlined ? Colors.transparent : btnColor,
          ),
          side: MaterialStateProperty.all(
            isOutlined ? BorderSide(color: btnColor, width: 1.5) : BorderSide.none,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            ),
          ),
        ),
        onPressed: isLoading ? null : ontap,
        child: isLoading
            ? SizedBox(
          width: 24.w,
          height: 24.w,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: txtColor),
            if (icon != null) SizedBox(width: 8.w),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: txtColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
