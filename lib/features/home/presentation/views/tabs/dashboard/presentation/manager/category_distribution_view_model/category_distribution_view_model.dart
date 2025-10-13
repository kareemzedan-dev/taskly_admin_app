import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/use_cases/category_distribution_use_case/category_distribution_use_case.dart';
import 'category_distribution_states.dart';

@injectable
class CategoryDistributionViewModel extends Cubit<CategoryDistributionStates> {
  final CategoryDistributionUseCase categoryDistributionUseCase;

  CategoryDistributionViewModel(this.categoryDistributionUseCase)
      : super(CategoryDistributionInitial());

  Future<void> getCategoryDistribution() async {
    try {
      emit(CategoryDistributionLoadingState());
      final result = await categoryDistributionUseCase.call();


      if (isClosed) return;

      result.fold(
            (l) {
          if (isClosed) return;
          emit(CategoryDistributionErrorState(message: l.message));
        },
            (r) {
          if (isClosed) return;
          emit(CategoryDistributionLoadedState(categoryDistribution: r));
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(CategoryDistributionErrorState(message: e.toString()));
      }
    }
  }
}
