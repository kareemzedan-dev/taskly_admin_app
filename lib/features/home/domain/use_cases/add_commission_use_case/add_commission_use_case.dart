import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/dashboard/dashboard_repos.dart';

@injectable
class AddCommissionUseCase {
  DashboardRepos dashboardRepos;
  AddCommissionUseCase(this.dashboardRepos);
  Future<Either<Failures,AdminSettingsEntity>> call( AdminSettingsEntity adminSettings)async{
    return await dashboardRepos.addCommission(adminSettings); 
  }
}