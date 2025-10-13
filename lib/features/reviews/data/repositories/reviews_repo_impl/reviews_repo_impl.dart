import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/data/data_sources/remote/reviews_remote_data_source/reviews_remote_data_source.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly_admin/features/reviews/domain/repositories/reviews_repo/reviews_repo.dart';
@Injectable(as: ReviewsRepo)  
class ReviewsRepoImpl implements ReviewsRepo{
  ReviewsRemoteDataSource remoteDataSource;
  ReviewsRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failures, void>> deleteReview(String reviewId) {
    return remoteDataSource.deleteReview(reviewId);
  }

  @override
  Future<Either<Failures, List<ReviewsEntity>>> getAllReviews() {
    return remoteDataSource.getAllReviews();
  }

  @override
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({required String userId, required String role}) {
    return remoteDataSource.getUserReviews(userId: userId, role: role);
  }
}