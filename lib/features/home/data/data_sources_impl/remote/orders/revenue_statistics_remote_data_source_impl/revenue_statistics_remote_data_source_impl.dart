import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/revenue_statistics_entity/revenue_statistics_entity.dart';
import '../../../../data_sources/remote/orders/revenue_statistics_remote_data_source/revenue_statistics_remote_data_source.dart';
import '../../../../models/revenue_statistics_model/revenue_statistics_model.dart';

@Injectable(as: RevenueStatisticsRemoteDataSource)
class RevenueStatisticsRemoteDataSourceImpl
    implements RevenueStatisticsRemoteDataSource {
  final SupabaseClient client;

  RevenueStatisticsRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failures, List<RevenueStatisticsEntity>>> getRevenueStatistics(
      String periodType,
      ) async {
    try {
      final response = await client
          .from('revenue_statistics')
          .select()
         //.eq('period_type', periodType)
          .order('period_date', ascending: false);

      final data = response as List<dynamic>;


      final List<RevenueStatisticsEntity> responseList = data
          .map((json) => RevenueStatisticsModel.fromJson(json))
          .toList();

      return Right(responseList);
    } on PostgrestException catch (e) {
      // ✅ لو حصل خطأ من قاعدة البيانات
      return Left(ServerFailure(e.message));
    } catch (e) {
      // ✅ fallback لأي خطأ تاني
      return Left(ServerFailure(e.toString()));
    }
  }
}
