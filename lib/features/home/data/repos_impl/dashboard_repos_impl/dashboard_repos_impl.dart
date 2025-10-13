import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';

import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';

import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../domain/repos/dashboard/dashboard_repos.dart';
import '../../data_sources/remote/orders/get_all_orders_remote_data_source/get_all_orders_remote_data_source.dart';
import '../../data_sources/remote/orders/get_order_by_id_remote_data_source/get_order_by_id_remote_data_source.dart';
import '../../data_sources/remote/payments/add_commission_remote_data_source/add_commission_remote_data_source.dart';
import '../../data_sources/remote/users/get_all_users_remote_data_source/get_all_users_remote_data_source.dart';
@Injectable(as: DashboardRepos)
class DashboardReposImpl extends DashboardRepos{
  final GetAllOrdersRemoteDataSource getAllOrdersRemoteDataSource;
  final GetAllUsersRemoteDataSource getAllUsersRemoteDataSource;
  final GetOrderByIdRemoteDataSource getOrderByIdRemoteDataSource;
  final AddCommissionRemoteDataSource addCommissionRemoteDataSource;
  DashboardReposImpl(this.getAllOrdersRemoteDataSource,  this.addCommissionRemoteDataSource,this.getAllUsersRemoteDataSource,this.getOrderByIdRemoteDataSource);
  @override
  Future<Either<Failures, List<OrderEntity>>> getAllOrders() {
    return getAllOrdersRemoteDataSource.getAllOrders();

  }

  @override
  Future<Either<Failures, List<UserEntity>>> getAllUsers() {
    return getAllUsersRemoteDataSource.getAllUsers();

  }

  @override
  Future<Either<Failures, AdminSettingsEntity>> addCommission(AdminSettingsEntity settings) {
 return addCommissionRemoteDataSource.addCommission(settings);
  }

  @override
  Future<Either<Failures, AdminSettingsEntity>> getCommission(String adminId) {
    // TODO: implement getCommission
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updateCommission(AdminSettingsEntity settings) {
    // TODO: implement updateCommission
    throw UnimplementedError();
  }



}