import 'package:either_dart/either.dart';
import 'package:taskly_admin/features/home/domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../data/models/revenue_statistics_model/revenue_statistics_model.dart';

abstract class RevenueStatisticsRepo {
  Future<Either<Failures, List<RevenueStatisticsEntity>>> getRevenueStatistics(String periodType);
}
