
import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';

abstract class ReviewsRepo {
 
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({
    required String userId,
    required String role,  
  });
 
  Future<Either<Failures, List<ReviewsEntity>>> getAllReviews();
 
  Future<Either<Failures, void>> deleteReview(String reviewId);
}
