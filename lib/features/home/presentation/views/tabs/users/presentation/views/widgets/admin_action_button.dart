
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;

  const AdminActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          border: Border.all(
            color: borderColor,
            width: 2.w,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor),
              SizedBox(width: 6.w),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
