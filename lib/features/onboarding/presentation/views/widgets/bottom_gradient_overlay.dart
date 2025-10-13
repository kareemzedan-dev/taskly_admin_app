import 'package:flutter/material.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class BottomGradientOverlay extends StatelessWidget {
  const BottomGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsManager.primary.withOpacity(0),
              ColorsManager.primary.withOpacity(0.1),
              ColorsManager.primary.withOpacity(0.3),
              ColorsManager.primary.withOpacity(0.6),
              ColorsManager.primary,
            ],
          ),
        ),
      ),
    );
  }
}
