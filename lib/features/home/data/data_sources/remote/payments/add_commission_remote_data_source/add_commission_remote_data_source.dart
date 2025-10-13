import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';

@injectable 
abstract class AddCommissionRemoteDataSource {
  Future<Either<Failures, AdminSettingsEntity>> addCommission(AdminSettingsEntity adminSettingsEntity);
}