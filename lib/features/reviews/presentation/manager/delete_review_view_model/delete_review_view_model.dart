import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/reviews/domain/use_cases/delete_reviews_use_case/delete_reviews_use_case.dart';
import 'package:taskly_admin/features/reviews/presentation/manager/delete_review_view_model/delete_review_states.dart';
@injectable
class DeleteReviewViewModel extends Cubit<DeleteReviewStates> {
  final DeleteReviewUseCase deleteReviewUseCase;

  DeleteReviewViewModel(this.deleteReviewUseCase)
      : super(DeleteReviewInitial());

  Future<void> deleteReview(String reviewId) async {
    try {
      emit(DeleteReviewLoading());

      final result = await deleteReviewUseCase.call(reviewId);

      result.fold(
        (failure) => emit(DeleteReviewError(failure.message)),
        (_) => emit(DeleteReviewSuccess()),
      );
    } catch (e) {
      emit(DeleteReviewError(e.toString()));
    }
  }
}
