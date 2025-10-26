import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/use_cases/auth/auth_use_case.dart';
import 'auth_states.dart';

@injectable
class AuthViewModel extends Cubit<AuthStates> {
  AuthViewModel({required this.authUseCase})
      : super(AuthRegisterInitialState());
  final AuthUseCase authUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _saveFcmToken(String userId) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) return;
    final platform = "android"; // ممكن تضيف شرط iOS لو حابب

    await supabase.from('user_devices').upsert(
      {
        'user_id': userId,
        'fcm_token': fcmToken,
        'platform': platform,
      },

    );
    print('✅ FCM token saved for user $userId');
  }

  void registerUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? role,
  }) async {
    try {
      emit(AuthRegisterLoadingState());
      final result = await authUseCase.callRegister(
        firstName!,
        lastName!,
        email!,
        password!,
        role!,
      );
      result.fold(
            (failure) => emit(AuthRegisterErrorState(failure)),
            (registerResponse) async {
          emit(AuthRegisterSuccessState(registerResponse));
          // حفظ FCM token بعد التسجيل
          await _saveFcmToken(registerResponse.user!.id!);
        },
      );
    } catch (e) {
      emit(AuthRegisterErrorState(ServerFailure(e.toString())));
    }
  }

  void loginUser({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      emit(AuthLoginLoadingState());
      final result = await authUseCase.callLogin(email, password, role);
      result.fold(
            (failure) => emit(AuthLoginErrorState(failure)),
            (user) async {
          emit(AuthLoginSuccessState(user));
          await _saveFcmToken(user.user!.id!);
        },
      );
    } catch (e) {
      emit(AuthLoginErrorState(ServerFailure(e.toString())));
    }
  }

  void googleLogin({required String role}) async {
    try {
      emit(AuthGoogleLoadingState());
      final result = await authUseCase.callGoogleLogin(role);
      result.fold(
            (failure) => emit(AuthGoogleErrorState(failure)),
            (googleResponse) async {
          emit(AuthGoogleSuccessState(googleResponse));
          // حفظ FCM token بعد Google Login
          await _saveFcmToken(googleResponse.user!.id);
        },
      );
    } catch (e) {
      emit(AuthGoogleErrorState(ServerFailure(e.toString())));
    }
  }
}
