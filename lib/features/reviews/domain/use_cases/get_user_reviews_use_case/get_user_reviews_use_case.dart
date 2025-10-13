import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly_admin/features/reviews/domain/repositories/reviews_repo/reviews_repo.dart';
@injectable
class GetUserReviewsUseCase {
  final ReviewsRepo repo;

  GetUserReviewsUseCase(this.repo);

  Future<Either<Failures, List<ReviewsEntity>>> call({
    required String userId,
    required String role,
  }) async {
    return await repo.getUserReviews(userId: userId, role: role);
  }
}
