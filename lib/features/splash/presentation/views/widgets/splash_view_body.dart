import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/config/routes/routes_manager.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/core/utils/strings_manager.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final token = SharedPrefHelper.getString(StringsManager.tokenKey);
  final onboardingSkip = SharedPrefHelper.getBool("onboarding_skip");

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    _navigateNext();
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = SharedPrefHelper.getString(StringsManager.tokenKey);
    final onboardingSkip = SharedPrefHelper.getBool("onboarding_skip") ?? false;

    if (mounted) {
      if (token == null || token.isEmpty) {

        if (!onboardingSkip) {
          Navigator.pushReplacementNamed(context, RoutesManager.onboarding);
        } else {
          Navigator.pushReplacementNamed(context, RoutesManager.login);
        }
      } else {
        Navigator.pushReplacementNamed(context, RoutesManager.homeView);
      }
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Text(
                "Taskly",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 50.sp,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
