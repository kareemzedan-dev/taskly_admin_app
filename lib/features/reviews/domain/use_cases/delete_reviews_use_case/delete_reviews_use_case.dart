import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/domain/repositories/reviews_repo/reviews_repo.dart';
@injectable

class DeleteReviewUseCase {
  final ReviewsRepo repo;

  DeleteReviewUseCase(this.repo);

  Future<Either<Failures, void>> call(String reviewId) async {
    return await repo.deleteReview(reviewId);
  }
}
