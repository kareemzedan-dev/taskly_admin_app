import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_admin_conversions_repo/get_admin_conversions_repo.dart';

@injectable
class GetConversationsUseCase {
  GetAdminConversionsRepo repos;
  GetConversationsUseCase(this.repos);

  Future<Either<Failures, List<UserEntity>>> call(String adminId) {
    return repos.getConversations(adminId);
  }
  Stream<List<UserEntity>> subscribeToConversations(String userId) {
    return repos.subscribeToConversations(userId);
  }
}