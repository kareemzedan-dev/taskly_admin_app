import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/models/admin_settings_model/admin_settings_model.dart';
import 'package:taskly_admin/features/home/domain/entities/admin_settings_entity/admin_settings_entity.dart';

import '../../../../data_sources/remote/payments/add_commission_remote_data_source/add_commission_remote_data_source.dart';

@Injectable(as: AddCommissionRemoteDataSource)
class AddCommissionRemoteDataSourceImpl
    implements AddCommissionRemoteDataSource {
  final SupabaseService supabaseService;

  AddCommissionRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, AdminSettingsEntity>> addCommission(
    AdminSettingsEntity adminSettingsEntity,
  ) async {
    try {
      if (NetworkUtils.hasInternet() == false) {
        return Left(NetworkFailure('No internet connection'));
      }
      final model = AdminSettingsModel(
        id: adminSettingsEntity.id,
        adminId: adminSettingsEntity.adminId,
        commission: adminSettingsEntity.commission,
        createdAt: adminSettingsEntity.createdAt,
        updatedAt: adminSettingsEntity.updatedAt,
      );

      final response = await supabaseService.upsert(
        table: 'admin_settings',
        data: model.toJson(),
        onConflict: 'admin_id',
      );

      return Right(AdminSettingsModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
