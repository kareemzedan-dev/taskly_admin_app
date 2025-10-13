import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/auth/presentation/views/widgets/login_view_body.dart';

import '../../../../core/di/di.dart';
import '../cubit/auth_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>  getIt<AuthViewModel>(),
          child: LoginViewBody(),
        ),
      ),
    );
  }
}
