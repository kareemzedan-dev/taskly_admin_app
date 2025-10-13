import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/user_entity/user_entity.dart';

abstract class PendingVerificationsRepo {
  Future<Either<Failures, List<UserEntity>>> getPendingVerifications();
}