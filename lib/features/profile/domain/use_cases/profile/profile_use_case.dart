import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
 import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../repositories/profile/profile_repo.dart';
@injectable
class ProfileUseCase {
  ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);
 Future<Either<Failures,UserEntity>> callUserInfo(
     String userId,


     ) => profileRepo.getUserInfo(
   userId,

 );
}