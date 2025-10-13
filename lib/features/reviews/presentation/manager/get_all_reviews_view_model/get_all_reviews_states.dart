import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';

abstract class GetAllReviewsStates {}

class GetAllReviewsInitial extends GetAllReviewsStates {}

class GetAllReviewsLoading extends GetAllReviewsStates {}

class GetAllReviewsSuccess extends GetAllReviewsStates {
  final List<ReviewsEntity> reviews;
  GetAllReviewsSuccess(this.reviews);
}

class GetAllReviewsError extends GetAllReviewsStates {
  final String message;
  GetAllReviewsError(this.message);
}
