import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/user_status_remote_data_source/user_status_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/user_status_entity/user_status_entity.dart';

import '../../../../domain/repos/messages_repos/user_status_repo/user_status_repo.dart';
@Injectable(as: UserStatusRepo )
class UserStatusRepoImpl implements UserStatusRepo{
  final UserStatusRemoteDataSource userStatusRemoteDataSource;
  UserStatusRepoImpl(this.userStatusRemoteDataSource);
  @override
  Stream<UserStatusEntity> streamUserStatus(String userId) {
   return userStatusRemoteDataSource.streamUserStatus(userId);
  }

}