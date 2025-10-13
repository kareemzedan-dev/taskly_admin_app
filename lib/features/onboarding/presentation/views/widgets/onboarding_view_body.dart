import 'package:flutter/material.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/onboarding/presentation/views/widgets/onboarding_page.dart';


class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}
 
class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context); 
    return PageView(
      controller: _pageController,
      onPageChanged: (value) {
        setState(() {
          _currentPage = value;
        });
        print(_currentPage);
      },

      children: [
        OnboardingPage(
          currentPage: _currentPage,
          text: local!.dashboardDescription,
          image: Assets.assetsImagesOnboarding1,
          
        ),
        OnboardingPage(
          currentPage: _currentPage,
          text:
               local.performanceTracking,
          image: Assets.assetsImagesOnboarding2,
        ),
      ],
    );
  }
}
