import 'package:either_dart/either.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../../../core/errors/failures.dart';

abstract class ProfileRepo {
    Future<Either<Failures,UserEntity>> getUserInfo(
        String userId,

        );
}