import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';
import '../../repos/dashboard/dashboard_repos.dart';
@injectable
class GetAllOrdersUseCase {
  final DashboardRepos dashboardRepos;
  GetAllOrdersUseCase({required this.dashboardRepos});
  Future<Either<Failures,List<OrderEntity>>> call()async{

    return await dashboardRepos.getAllOrders();
  }
}