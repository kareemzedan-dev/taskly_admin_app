import 'package:either_dart/src/either.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


import '../../../../../core/cache/shared_preferences.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/supabase_service.dart';
import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/utils/network_utils.dart';
import '../../../../../core/utils/strings_manager.dart';
import '../../../domain/entities/google_response_entity/google_response_entity.dart';
import '../../../domain/entities/login_response_entity/login_response_entity.dart';
import '../../../domain/entities/register_response_entity/register_response_entity.dart';
import '../../data_sources/remote/auth_remote_data_source.dart';
import '../../models/google_response_dm/google_response_dm.dart';
import '../../models/login_response_dm/login_response_dm.dart';
import '../../models/register_response_dm/register_response_dm.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  late final SupabaseClient supabaseClient;
  late final SupabaseService supabaseService;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: ConstantsManager.supabaseServerClientId,
    scopes: ['email', 'profile'],
  );

  static final String _adminRole = StringsManager.adminRole;

  AuthRemoteDataSourceImpl() {
    supabaseClient = Supabase.instance.client;
    supabaseService = SupabaseService(supabaseClient);
  }

  Future<void> _saveUserLocally({
    required String token,
    required String id,
    required String fullName,
    required String email,
  }) async {
    await SharedPrefHelper.setString(StringsManager.tokenKey, token);
    await SharedPrefHelper.setString(StringsManager.idKey, id);
    await SharedPrefHelper.setString(StringsManager.fullNameKey, fullName);
    await SharedPrefHelper.setString(StringsManager.emailKey, email);
    await SharedPrefHelper.setString(StringsManager.roleKey, _adminRole);
  }

  Future<void> _saveUserToSupabase({
    required String id,
    required String fullName,
    required String email,
    String? avatarUrl,
  }) async {
    await supabaseService.sendDataToSupabase(
      tableName: 'admins',
      data: {
        'id': id,
        'first_name': fullName.split(' ').first,
        'last_name': fullName.split(' ').last,
        'email': email,
        'role': _adminRole,
        'profile_image': avatarUrl,
      },
      conflictColumn: 'email',
    );
  }

  Future<void> _handleUserAfterAuth({
    required String id,
    required String fullName,
    required String email,
    required String token,
    String? avatarUrl,
  }) async {
    await _saveUserLocally(
      id: id,
      fullName: fullName,
      email: email,
      token: token,
    );
    await _saveUserToSupabase(
      id: id,
      fullName: fullName,
      email: email,
      avatarUrl: avatarUrl,
    );
  }@override
  Future<Either<Failures, RegisterResponseEntity>> register(
      String firstName,
      String lastName,
      String email,
      String password,
      String role,
      ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      const fixedRole = StringsManager.adminRole;

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null && response.session == null) {
        return Left(ServerFailure(StringsManager.emailAlreadyExists));
      }

      final user = response.user!;
      final token = response.session?.accessToken ?? '';

      // احفظ في جدول admins
      await _handleUserAfterAuth(
        id: user.id,
        fullName: "$firstName $lastName",
        email: user.email!,
        token: token,
      );

      final registerResponse = RegisterResponseDm(
        user: UserDm(
          firstName: firstName,
          lastName: lastName,
          email: user.email,
          password: password,
          role: fixedRole,
        ),
        message: StringsManager.userRegisteredSuccessfully,
        token: token,
      );

      return Right(registerResponse);
    } on AuthException catch (e) {
      debugPrint("Error: $e");
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      debugPrint("Error: $e\n$stackTrace");
      return Left(ServerFailure(StringsManager.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
      String email,
      String password,
      String role,
      ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      const fixedRole = StringsManager.adminRole;

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      final session = response.session;
      if (user == null || session == null) {
        return Left(ServerFailure(StringsManager.loginFailed));
      }

      // اقرأ بيانات المستخدم من جدول admins
      final userData = await supabase
          .from('admins')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (userData == null) {
        return Left(ServerFailure(StringsManager.notRegisteredAsRole));
      }

      // اتأكد من الدور
      final userRole = userData['role'] ?? '';
      if (userRole != fixedRole) {
        return Left(ServerFailure(StringsManager.notRegisteredAsRole));
      }

      final fullName =
          "${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}";

      await _handleUserAfterAuth(
        id: user.id,
        fullName: fullName,
        email: user.email ?? '',
        token: session.accessToken,
      );

      final loginResponse = LoginResponseDm(
        user: LoginUserDm(email: user.email, password: password),
        message: StringsManager.userLoginSuccessfully,
        token: session.accessToken,
      );

      return Right(loginResponse);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      debugPrint("Error: $e\n$stackTrace");
      return Left(ServerFailure(StringsManager.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failures, GoogleAuthResponseEntity>> googleLogin(
      String role,
      ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      const fixedRole = StringsManager.adminRole;

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return Left(ServerFailure(StringsManager.googleLoginCancelled));
      }

      final GoogleSignInAuthentication googleAuth =
      await account.authentication;

      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (res.user == null || res.session == null) {
        return Left(ServerFailure(StringsManager.loginFailed));
      }
      final supabaseUser = res.user!;
      final supabaseToken = res.session!.accessToken;
      final email = account.email;
      final fullName = account.displayName ?? '';
      final avatarUrl = account.photoUrl;
      final existingUser = await supabase
          .from('admins')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (existingUser != null && existingUser['role'] != fixedRole) {
        return Left(ServerFailure(
          StringsManager.accountAlreadyRegistered,
          params: {
            "existingRole": existingUser['role'],
            "role": fixedRole,
          },
        ));
      }

      final userId =
      existingUser != null ? existingUser['id'] : supabaseUser.id;

      await _handleUserAfterAuth(
        id: userId,
        fullName: fullName,
        email: email,
        token: supabaseToken,
        avatarUrl: avatarUrl,
      );

      final googleResponse = GoogleAuthResponseDm(
        token: supabaseToken,
        user: GoogleUserDm(
          id: userId,
          name: fullName,
          email: email,
          role: fixedRole,
          avatarUrl: avatarUrl,
        ),
        message: StringsManager.googleLoginSuccessful,
      );

      return Right(googleResponse);
    } catch (e, stackTrace) {
      debugPrint("Error: $e\n$stackTrace");
      return Left(ServerFailure(StringsManager.somethingWentWrong));
    }
  }


}
