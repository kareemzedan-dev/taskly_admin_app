import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

abstract class  GetAdminConversionsRepo {
   Future<Either<Failures ,List<UserEntity>>> getConversations(String adminId);
   Stream<List<UserEntity>> subscribeToConversations(String userId);

}