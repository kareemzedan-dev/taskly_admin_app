import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;
  final double? indicatorWeight;
  final TabBarIndicatorSize indicatorSize;
  final bool isScrollable;
  final TabAlignment tabAlignment;
  final TabController? controller; // ✅ أضفنا ده

  const CustomTabBar({
    super.key,
    required this.tabs,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.indicatorWeight = 4,
    this.indicatorSize = TabBarIndicatorSize.tab,
    this.isScrollable = false,
    this.tabAlignment = TabAlignment.fill,
    this.controller, // ✅ أضفنا ده
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller, // ✅ استخدمنا الـ controller هنا
      isScrollable: isScrollable,
      labelColor: labelColor ?? ColorsManager.primary,
      unselectedLabelColor: unselectedLabelColor ?? Colors.grey,
      labelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      indicatorColor: indicatorColor ?? ColorsManager.primary,
      indicatorWeight: indicatorWeight ?? 4,
      indicatorSize: indicatorSize,
      tabs: tabs.map((widget) => Tab(child: widget)).toList(),
      tabAlignment: tabAlignment,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.h);
}
