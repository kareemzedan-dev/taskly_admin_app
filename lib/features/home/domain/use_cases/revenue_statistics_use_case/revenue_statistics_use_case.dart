
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/revenue_statistics_entity/revenue_statistics_entity.dart';
import '../../repos/dashboard/revenue_statistics_repo/revenue_statistics_repo.dart';
@injectable
class GetRevenueStatisticsUseCase {
  final RevenueStatisticsRepo repository;

  GetRevenueStatisticsUseCase(this.repository);

  Future<Either<Failures, List<RevenueStatisticsEntity>>> call(String periodType) async {
    return await repository.getRevenueStatistics(periodType);
  }
}
