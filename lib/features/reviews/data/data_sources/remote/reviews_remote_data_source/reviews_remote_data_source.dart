import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';

abstract class ReviewsRemoteDataSource {
  /// get all reviews related to a specific user (client or freelancer)
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({
    required String userId,
    required String role,
  });

  /// get all reviews in the system (for admin panel)
  Future<Either<Failures,List<ReviewsEntity>>> getAllReviews();

  /// delete a specific review by id
  Future<Either<Failures,void>> deleteReview(String reviewId);
}
