import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/components/custom_text_field.dart';
import 'package:taskly_admin/core/components/or_divider.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/auth/presentation/views/widgets/social_login_button.dart';

import '../../../../../config/routes/routes_manager.dart';
import '../../../../../core/components/dismissible_error_card.dart';
import '../../../../../core/di/di.dart';
import '../../cubit/auth_states.dart';
import '../../cubit/auth_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key,});


  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  AuthViewModel authViewModel = getIt<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
       final local = AppLocalizations.of(context); 
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: authViewModel.formKey,
            autovalidateMode: authViewModel.autovalidateMode,
            child: BlocListener<AuthViewModel, AuthStates>(
              listener: (context, state) {
                if (state is AuthRegisterLoadingState ||
                    state is AuthGoogleLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        Center(
                          child: LoadingAnimationWidget.threeRotatingDots(
                            size: 60,
                            color: ColorsManager.primary,
                          ),
                        ),
                  );
                }

                // Success states
                if (state is AuthRegisterSuccessState ||
                    state is AuthGoogleSuccessState) {
                  if (mounted) Navigator.pop(context); // close dialog first
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesManager.homeView, (_) => false);
                  }

                  if (state is AuthRegisterErrorState ||
                      state is AuthGoogleErrorState) {
                    if (mounted) Navigator.pop(context);

                    final errorMsg = state is AuthRegisterErrorState &&
                        state.error.message.contains("user_already_exists")
                        ? "This email is already registered"
                        : local.somethingWentWrong;

                    showTemporaryMessage(context, errorMsg, MessageType.error);
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Taskly",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                        color: ColorsManager.primary,
                        fontSize: 30.sp,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Text(
                    local!.signUp,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontSize: 20.sp,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          prefixIcon: Icon(CupertinoIcons.person),

                          hintText: local.firstName,
                          textEditingController: authViewModel.fNameController,


                          validator:
                              (p0) =>
                          p0!.isEmpty ?local.thisFieldIsRequired : null,
                          keyboardType: TextInputType.text,
                          onSaved: (p0) {

                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CustomTextFormField(
                          prefixIcon: Icon(CupertinoIcons.person),

                          hintText: local.lastName,
                          textEditingController: authViewModel.lNameController,


                          validator:
                              (p0) =>
                          p0!.isEmpty ? local.thisFieldIsRequired : null,
                          keyboardType: TextInputType.text,
                          onSaved: (p0) {

                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  CustomTextFormField(

                    prefixIcon: Icon(CupertinoIcons.mail),
                    hintText: local.email,
                    textEditingController: authViewModel.emailController,
                    validator:
                        (p0) => p0!.isEmpty ? local.thisFieldIsRequired : null,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (p0) {},
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(

                    prefixIcon: Icon(CupertinoIcons.lock),
                    hintText: local.password,
                    textEditingController: authViewModel.passwordController,
                    iconShow: true,
                    validator:
                        (p0) => p0!.isEmpty ?local.thisFieldIsRequired : null,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (p0) {},
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(height: 30.h),
                  OrDivider(),
                  SizedBox(height: 20.h),
                  SocialLoginButton(
                    label:local.continueWithGoogle,
                    iconPath: Assets.assetsImagesIcGoogle,
                    onPressed: () {
                      context.read<AuthViewModel>().googleLogin(role: "admin");
                    },
                  ),
                  SizedBox(height: 48.h),

                  CustomButton(
                    title:local.createAccount,
                    ontap: () {
                      if (authViewModel.formKey.currentState!.validate()) {
                        context.read<AuthViewModel>().registerUser(
                          firstName: authViewModel.fNameController.text,
                          lastName: authViewModel.lNameController.text,
                          email: authViewModel.emailController.text,
                          password: authViewModel.passwordController.text,
                          role: "admin",
                        );
                      } else {
                        setState(() {
                          authViewModel.autovalidateMode =
                              AutovalidateMode.onUserInteraction;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      local.alreadyHaveAccount,

                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          color: Colors.grey,

                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 5.w,),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                         local.login,

                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            color: ColorsManager.primary,

                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
