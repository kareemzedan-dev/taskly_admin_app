import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/repos/users/users_repos.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';

@injectable
class OrdersByUserUseCase {
  final UsersRepos usersRepos;
  OrdersByUserUseCase(this.usersRepos);
  Future<Either<Failures,List<OrderEntity>>> call(String id,String role)async{
    return await usersRepos.getOrdersByUser(id, role);
  }
}