import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/user_entity/user_entity.dart';


abstract class PendingVerificationsRemoteDataSource {
  Future<Either<Failures, List<UserEntity>>> getPendingVerifications();
}