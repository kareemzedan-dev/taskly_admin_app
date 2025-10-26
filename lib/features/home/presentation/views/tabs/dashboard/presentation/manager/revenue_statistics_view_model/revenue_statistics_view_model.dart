import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/repos/dashboard/revenue_statistics_repo/revenue_statistics_repo.dart';
import 'package:taskly_admin/features/home/domain/use_cases/revenue_statistics_use_case/revenue_statistics_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/manager/revenue_statistics_view_model/revenue_statistics_states.dart';
@injectable
class RevenueStatisticsViewModel extends Cubit<RevenueStatisticsStates> {
  final GetRevenueStatisticsUseCase getRevenueStatisticsUseCase ;
  RevenueStatisticsViewModel(this.getRevenueStatisticsUseCase) : super(RevenueStatisticsStatesInitial());

  Future<void> getRevenueStatistics(String periodType) async {
    emit(RevenueStatisticsStatesLoading());
    final result = await getRevenueStatisticsUseCase(periodType);
    result.fold(
      (failure) => emit(RevenueStatisticsStatesError(message: failure.message)),
      (revenueStatistics) => emit(RevenueStatisticsStatesSuccess(revenueStatistics: revenueStatistics)),
    );
  }

}