import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/google_response_entity/google_response_entity.dart';
import '../../../domain/entities/login_response_entity/login_response_entity.dart';
import '../../../domain/entities/register_response_entity/register_response_entity.dart';
import '../../../domain/repos/auth/auth_repo.dart';
import '../../data_sources/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthRemoteDataSource authRemoteDataSource ;
  AuthRepoImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failures, RegisterResponseEntity>> register(String firstName, String lastName, String email, String password, String role) {
    return authRemoteDataSource.register(firstName, lastName, email, password, role);
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(String email, String password, String role) {
    return authRemoteDataSource.login(email, password, role);
  }

  @override
  Future<Either<Failures, GoogleAuthResponseEntity>> googleLogin({required String role}) {
 return authRemoteDataSource.googleLogin(role);
  }

}