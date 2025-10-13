import 'package:flutter/material.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        color:  ColorsManager.primary,
        ),
        child: const SplashViewBody(),
      ),
    );
  }
}
