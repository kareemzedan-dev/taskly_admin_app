
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';
import '../../../domain/repos/dashboard/revenue_statistics_repo/revenue_statistics_repo.dart';
import '../../data_sources/remote/orders/revenue_statistics_remote_data_source/revenue_statistics_remote_data_source.dart';
@Injectable(as: RevenueStatisticsRepo)
class RevenueStatisticsRepositoryImpl implements RevenueStatisticsRepo {
  final RevenueStatisticsRemoteDataSource remoteDataSource;

  RevenueStatisticsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, List<RevenueStatisticsEntity>>>getRevenueStatistics(
      String periodType) async {
    return await remoteDataSource.getRevenueStatistics(periodType);
  }
}
