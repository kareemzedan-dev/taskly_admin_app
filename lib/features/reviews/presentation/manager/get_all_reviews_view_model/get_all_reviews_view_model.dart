import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly_admin/features/reviews/domain/use_cases/get_all_reviews_use_case/get_all_review_use_case.dart';
import 'package:taskly_admin/features/reviews/presentation/manager/get_all_reviews_view_model/get_all_reviews_states.dart';
@injectable
class GetAllReviewsViewModel extends Cubit<GetAllReviewsStates> {
  final GetAllReviewsUseCase getAllReviewsUseCase;

  GetAllReviewsViewModel(this.getAllReviewsUseCase)
      : super(GetAllReviewsInitial());

  Future<void> getAllReviews() async {
    try {
      emit(GetAllReviewsLoading());

      final result = await getAllReviewsUseCase.call();

      result.fold(
        (failure) => emit(GetAllReviewsError(failure.message)),
        (reviews) => emit(GetAllReviewsSuccess(reviews)),
      );
    } catch (e) {
      emit(GetAllReviewsError(e.toString()));
    }
  }
 

}
