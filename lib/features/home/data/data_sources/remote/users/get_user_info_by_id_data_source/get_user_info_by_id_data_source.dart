import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/user_entity/user_entity.dart';


abstract class GetUserInfoByIdRemoteDataSource {
  Future<Either<Failures,UserEntity>> getUserInfoById(String id)  ;

}