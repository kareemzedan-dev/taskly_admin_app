import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import '../../../domain/repos/users/users_repos.dart';
import '../../data_sources/remote/orders/get_order_by_id_remote_data_source/get_order_by_id_remote_data_source.dart';
import '../../data_sources/remote/users/update_user_status_remote_data_source/update_user_status_remote_data_source.dart';
@Injectable(as: UsersRepos)
class UsersReposImpl implements UsersRepos{
  GetOrderByIdRemoteDataSource getOrderByIdRemoteDataSource;
  UpdateUserStatusRemoteDataSource updateUserStatusRemoteDataSource;
  UsersReposImpl(this.getOrderByIdRemoteDataSource,this.updateUserStatusRemoteDataSource);
  @override
  Future<Either<Failures, List<OrderEntity>>> getOrdersByUser(String id,String role) {
    return getOrderByIdRemoteDataSource.getOrdersByUser(id,role);
  }
  
@override
Future<Either<Failures, void>> updateUserStatus(String userId, {String? status, bool? isVerified, required String role}) async {
  try {
    await updateUserStatusRemoteDataSource.updateUserStatus(userId, status: status , isVerified: isVerified , role: role);
    return const Right(null);  
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}



}