import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/user_entity/user_entity.dart';
import '../../repos/dashboard/dashboard_repos.dart';
@injectable
class GetAllUsersUseCase {
  final DashboardRepos dashboardRepos;
  GetAllUsersUseCase({required this.dashboardRepos});
  Future<Either<Failures,List<UserEntity>>> call()async{
    return await dashboardRepos.getAllUsers();
  }
}