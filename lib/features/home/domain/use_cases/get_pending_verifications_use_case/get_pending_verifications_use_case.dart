import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/user_entity/user_entity.dart';
import '../../repos/pending_verifications_repo/pending_verifications_repo.dart';
@injectable
class GetPendingVerificationsUseCase {
  final PendingVerificationsRepo pendingVerificationsRepo;
  GetPendingVerificationsUseCase(this.pendingVerificationsRepo);
  Future<Either<Failures, List<UserEntity>>> call() async {
    return await pendingVerificationsRepo.getPendingVerifications();
  }
}