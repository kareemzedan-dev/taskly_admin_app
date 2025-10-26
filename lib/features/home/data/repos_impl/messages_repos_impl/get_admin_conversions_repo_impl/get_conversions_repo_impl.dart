import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/get_admin_conversations_remote_data_source/get_admin_conversations_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repos/messages_repos/get_admin_conversions_repo/get_admin_conversions_repo.dart';

@Injectable(as:  GetAdminConversionsRepo)
class GetAdminConversionsRepoImpl implements GetAdminConversionsRepo{
  final GetAdminConversationsRemoteDataSource getConversationsRemoteDataSource;

  GetAdminConversionsRepoImpl({required this.getConversationsRemoteDataSource});

  @override
  Future<Either<Failures, List<UserEntity>>> getConversations(String adminId) {
    return getConversationsRemoteDataSource.getConversations(adminId);
  }
  @override
  Stream<List<UserEntity>> subscribeToConversations(String userId) {
    return getConversationsRemoteDataSource.subscribeToConversations(userId);
  }
}