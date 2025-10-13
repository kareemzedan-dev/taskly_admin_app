import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../entities/order_entity/order_entity.dart';

abstract class DashboardRepos{
  Future<Either<Failures,List<UserEntity>>> getAllUsers();
  Future<Either<Failures,List<OrderEntity>>> getAllOrders();
  Future< Either<Failures, AdminSettingsEntity>> getCommission(String adminId);
  Future< Either<Failures, void>> updateCommission(AdminSettingsEntity settings);
  Future<Either<Failures,  AdminSettingsEntity>> addCommission(  AdminSettingsEntity settings);

}