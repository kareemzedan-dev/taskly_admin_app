import '../../../../../../../domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';

class RevenueStatisticsStates {}
class RevenueStatisticsStatesInitial extends RevenueStatisticsStates {}

class RevenueStatisticsStatesLoading extends RevenueStatisticsStates {}

class RevenueStatisticsStatesSuccess extends RevenueStatisticsStates {
  final List<RevenueStatisticsEntity> revenueStatistics;

  RevenueStatisticsStatesSuccess({required this.revenueStatistics});
}

class RevenueStatisticsStatesError extends RevenueStatisticsStates {
  final String message;

  RevenueStatisticsStatesError({required this.message});
}
