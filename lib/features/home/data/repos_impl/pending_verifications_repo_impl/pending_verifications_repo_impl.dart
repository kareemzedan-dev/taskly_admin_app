import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly_admin/core/errors/failures.dart';

import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../domain/repos/pending_verifications_repo/pending_verifications_repo.dart';
import '../../data_sources/remote/users/pending_verifications_remote_data_source/pending_verifications_remote_data_source.dart';
@Injectable(as: PendingVerificationsRepo)
class PendingVerificationsRepoImpl implements PendingVerificationsRepo {
  final PendingVerificationsRemoteDataSource pendingVerificationsRemoteDataSource;
  PendingVerificationsRepoImpl(this.pendingVerificationsRemoteDataSource);

  @override
  Future<Either<Failures, List<UserEntity>>> getPendingVerifications() {
 return pendingVerificationsRemoteDataSource.getPendingVerifications();
  }

}