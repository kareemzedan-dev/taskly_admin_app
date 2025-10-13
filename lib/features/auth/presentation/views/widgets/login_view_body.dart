import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/components/custom_text_field.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/config/routes/routes_manager.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import '../../../../../core/components/dismissible_error_card.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../cubit/auth_states.dart';
import '../../cubit/auth_view_model.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool _obscurePassword = true;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // ربط الـ ViewModel
  AuthViewModel authViewModel = getIt<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorsManager.primary.withOpacity(0.5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: authViewModel.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: BlocListener<AuthViewModel, AuthStates>(
              listener: (context, state) {
                if (state is AuthLoginLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                        size: 60,
                        color: ColorsManager.primary,
                      ),
                    ),
                  );
                }

                if (state is AuthLoginSuccessState) {
                  if (mounted) Navigator.pop(context);
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesManager.homeView, (_) => false);
                  }
                }

                if (state is AuthLoginErrorState) {
                  if (mounted) Navigator.pop(context);
                  showTemporaryMessage(
                    context,
                    local.somethingWentWrong,
                    MessageType.error,
                  );
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 670.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 500.h,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Image.asset(
                                Assets.assetsImagesAdmin,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black87],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 40.h),
                                  child: Text(
                                    local.welcomeAdmin, // من localization
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _emailFocus.hasFocus
                                    ? Color(0xFF2fa4fa)
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              color: ColorsManager.black,
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 12.w),
                                Icon(
                                  Icons.email,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 22,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: TextFormField(
                                    focusNode: _emailFocus,
                                    controller: authViewModel.emailController,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: local.email,
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    validator: (p0) =>
                                    p0!.isEmpty ? local.thisFieldIsRequired : null,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _passwordFocus.hasFocus
                                    ? Color(0xFF2fa4fa)
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              color: ColorsManager.black,
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 12.w),
                                Icon(
                                  Icons.lock,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 24,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: TextFormField(
                                    focusNode: _passwordFocus,
                                    controller: authViewModel.passwordController,
                                    obscureText: _obscurePassword,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: local.password,
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    validator: (p0) =>
                                    p0!.isEmpty ? local.thisFieldIsRequired : null,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        gradient: LinearGradient(
                          colors: [
                            ColorsManager.primary,
                            ColorsManager.primary.withOpacity(0.8)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.r),
                        onTap: () {
                          if (authViewModel.formKey.currentState!.validate()) {
                            context.read<AuthViewModel>().loginUser(
                              email: authViewModel.emailController.text,
                              password: authViewModel.passwordController.text,
                              role: 'admin',
                            );
                          } else {
                            setState(() {
                              authViewModel.autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });
                          }
                        },
                        child: Center(
                          child: Text(
                            local.login, // من localization
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
