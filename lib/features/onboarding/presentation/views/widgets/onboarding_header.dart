import 'package:flutter/material.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'package:taskly_admin/config/routes/routes_manager.dart';
import 'package:taskly_admin/core/utils/app_text_styles.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/onboarding/presentation/views/widgets/onboarding_indicator.dart';

class OnboardingHeader extends StatelessWidget {
  OnboardingHeader({
    super.key,
    required this.containerColor,
    required this.currentPage,
  });

  Color? containerColor;
  int currentPage;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Positioned.fill(
      child: Container(
        color: containerColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      2,
                      (index) => OnboardingIndicator(
                        index: index,
                        currentIndex: currentPage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(60),
                    //     child: Image.asset(
                    //       Assets.assetsImagesTadbeer,
                    //       height: 50,
                    //       width: 50,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Taskly",
                        style: AppTextStyles.bold20.copyWith(
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (currentPage != 1) {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await SharedPrefHelper.setBool(
                                  "onboarding_skip",
                                  true,
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                     RoutesManager.login,
                                );
                              },
                              child: Text(
                                currentPage != 1 ? local!.skip : local!.letsGo,
                                style: AppTextStyles.bold20.copyWith(
                                  color: ColorsManager.white,
                                ),
                              ),
                            ),
                            if (currentPage == 1)
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: ColorsManager.white,
                                size: 16,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
