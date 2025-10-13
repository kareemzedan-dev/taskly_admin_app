  import 'package:flutter/material.dart';
import 'package:taskly_admin/features/onboarding/presentation/views/widgets/bottom_gradient_overlay.dart';
import 'package:taskly_admin/features/onboarding/presentation/views/widgets/onboarding_brand_section.dart';
import 'package:taskly_admin/features/onboarding/presentation/views/widgets/onboarding_header.dart';
 

Stack OnboardingPage({required int currentPage,required String text,required String image} ) {
 
    return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset( image ,  fit: BoxFit.cover),

          OnboardingBrandSection(
            text: text,
            logoShow: false,
          ),
              OnboardingHeader(
        containerColor: Colors.black.withOpacity(0.3),
        currentPage: currentPage,
      ),
          BottomGradientOverlay(),
          
        ],
      );
  }

 