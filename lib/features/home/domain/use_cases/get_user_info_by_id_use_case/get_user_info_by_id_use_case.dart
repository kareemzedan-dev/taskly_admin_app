import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/user_entity/user_entity.dart';
import '../../repos/orders/orders_repos.dart';
@injectable
class GetUserInfoByIdUseCase {
  final OrdersRepos ordersRepos;
  GetUserInfoByIdUseCase(this.ordersRepos);
  Future<Either<Failures,UserEntity>> call(String id) {
    return ordersRepos.getUserInfoById(id);
  }
}