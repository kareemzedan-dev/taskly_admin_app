import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';
import '../../../../models/revenue_statistics_model/revenue_statistics_model.dart';

abstract class RevenueStatisticsRemoteDataSource {
  Future<Either<Failures, List<RevenueStatisticsEntity>>> getRevenueStatistics(String periodType);
}
