import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
 

import '../../../../../core/errors/failures.dart';
import '../../entities/google_response_entity/google_response_entity.dart';
import '../../entities/login_response_entity/login_response_entity.dart';
import '../../entities/register_response_entity/register_response_entity.dart';
import '../../repos/auth/auth_repo.dart';


 @injectable
class AuthUseCase {
  AuthRepo authRepo;

  AuthUseCase(this.authRepo);

  Future<Either<Failures, RegisterResponseEntity>> callRegister(
    String firstName,
    String lastName,
    String email,
    String password,
    String role
  ) => authRepo.register(firstName, lastName, email, password, role);
  
   Future<Either<Failures, LoginResponseEntity>> callLogin(
    String email,
    String password,
    String role
  ) => authRepo.login(email, password,role);

   Future<Either<Failures,GoogleAuthResponseEntity>> callGoogleLogin(
  String role
       )=>authRepo.googleLogin(role: role);
}
