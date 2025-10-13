abstract class DeleteReviewStates {}

class DeleteReviewInitial extends DeleteReviewStates {}

class DeleteReviewLoading extends DeleteReviewStates {}

class DeleteReviewSuccess extends DeleteReviewStates {}

class DeleteReviewError extends DeleteReviewStates {
  final String message;
  DeleteReviewError(this.message);
}
