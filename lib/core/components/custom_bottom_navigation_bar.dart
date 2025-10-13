import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.firstTabName,
    this.firstTabicon,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final String? firstTabName;
  final String? firstTabicon;

  @override
  Widget build(BuildContext context) {
       final local = AppLocalizations.of(context); 
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.transparent,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.transparent,
      ),
      selectedItemColor: ColorsManager.primary,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            firstTabicon ?? Assets.assetsImagesDashboard,
            color: Colors.black.withOpacity(0.5),
            height: 24.h,
            width: 24.w,
          ),
          activeIcon: Image.asset(
            firstTabicon ?? Assets.assetsImagesDashboard,
            color: ColorsManager.primary,
            height: 24.h,
            width: 24.w,
          ),
          label: local!.dashboard,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.assetsImagesCommunity,
            color: Colors.black.withOpacity(0.5),
            height: 24.h,
            width: 24.w,
          ),
          activeIcon: Image.asset(
            Assets.assetsImagesCommunity,
            color: ColorsManager.primary,
            height: 24.h,
            width: 24.w,
          ),
          label:  local.users,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.assetsImagesDocument10103871,
            color: Colors.black.withOpacity(0.5),
            height: 24.h,
            width: 24.w,
          ),
          activeIcon: Image.asset(
            Assets.assetsImagesDocument10103871,
            color: ColorsManager.primary,
            height: 24.h,
            width: 24.w,
          ),
          label:local.orders,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.assetsImagesChat6431892,
            color: Colors.black.withOpacity(0.5),
            height: 24.h,
            width: 24.w,
          ),
          activeIcon: Image.asset(
            Assets.assetsImagesChat6431892,
            color: ColorsManager.primary,
            height: 24.h,
            width: 24.w,
          ),
          label:local.messages,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.assetsImagesWallet2527857,
            color: Colors.black.withOpacity(0.5),
            height: 24.h,
            width: 24.w,
          ),
          activeIcon: Image.asset(
            Assets.assetsImagesWallet2527857,
            color: ColorsManager.primary,
            height: 24.h,
            width: 24.w,
          ),
          label: local.payments,
        ),
      ],
    );
  }
}
