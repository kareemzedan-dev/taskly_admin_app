import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class OrderProgressTimeline extends StatelessWidget {
  final List<String> steps;
  final int currentStep;
  final Color activeColor;
  final Color inactiveColor;

  const OrderProgressTimeline({
    super.key,
    required this.steps,
    required this.currentStep,
    this.activeColor = ColorsManager.primary,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isEven) {
          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;

          return SizedBox(
            width: 80.w, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: isActive ? activeColor : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? activeColor : inactiveColor,
                      width: 2.w,
                    ),
                  ),
                  child: Center(
                    child: isActive
                        ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                        : Icon(Icons.circle_outlined,
                            size: 16.sp, color: inactiveColor),
                  ),
                ),
                SizedBox(height: 6.h),
                Flexible(
                  child: Text(
                    steps[stepIndex],
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isActive ? activeColor : inactiveColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          final leftStep = index ~/ 2;
          final isActive = leftStep < currentStep;

          return Expanded(
            child: Center(
              child: Container(
                height: 3.h,
                color: isActive
                    ? activeColor
                    : inactiveColor.withOpacity(0.3),
              ),
            ),
          );
        }
      }),
    );
  }
}
