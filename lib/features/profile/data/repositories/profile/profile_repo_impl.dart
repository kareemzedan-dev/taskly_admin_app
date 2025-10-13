import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repositories/profile/profile_repo.dart';
import '../../data_sources/profile_remote_data_source.dart';
@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo{
  ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl(this.profileRemoteDataSource);
  @override
  Future<Either<Failures, UserEntity>> getUserInfo(
      String userId,

      ) {
    return profileRemoteDataSource.getUserInfo(
      userId,

    );

 
  }

}