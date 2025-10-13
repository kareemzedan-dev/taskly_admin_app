import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/repos/users/users_repos.dart';

@injectable
class UpdateUserStatusUseCase {
  final UsersRepos usersRepos;
  UpdateUserStatusUseCase(this.usersRepos);
  Future<Either<Failures, void>> call(
    String userId,
 {String? status, bool? isVerified, required String role}
  ) => usersRepos.updateUserStatus(userId,status:  status ,isVerified: isVerified,role:   role);
}
