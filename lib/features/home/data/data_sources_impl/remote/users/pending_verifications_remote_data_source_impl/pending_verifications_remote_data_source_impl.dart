import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../../../../../core/utils/network_utils.dart';
import '../../../../data_sources/remote/users/pending_verifications_remote_data_source/pending_verifications_remote_data_source.dart';
import '../../../../models/user_model/user_model.dart';

@Injectable(as: PendingVerificationsRemoteDataSource)
class PendingVerificationsRemoteDataSourceImpl
    implements PendingVerificationsRemoteDataSource {
  final SupabaseService supabaseService;

  PendingVerificationsRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, List<UserEntity>>> getPendingVerifications() async {
    try {
      if(NetworkUtils.hasInternet() == false ){
        return Left(Failures('No Internet Connection'));
      }
      final response = await supabaseService.supabaseClient
          .from('freelancers')
          .select('*')
          .eq('is_verified', false);

      if (response.isEmpty) {
        return const Right([]);
      }

      final users = response
          .map<UserEntity>((e) => UserModel.fromJson(e))
          .toList();

      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
