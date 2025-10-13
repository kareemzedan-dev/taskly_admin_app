import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';

abstract class UsersRepos{
  Future<Either<Failures,List<OrderEntity>>> getOrdersByUser(String id,String role);
  Future<Either<Failures,void>> updateUserStatus(String userId, {String? status, bool? isVerified, required String role});
}