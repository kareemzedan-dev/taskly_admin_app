import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/domain/entities/category_distribution_entity/category_distribution_entity.dart';

import '../../../../data_sources/remote/orders/category_distribution_remote_data_source/category_distribution_remote_data_source.dart';
@Injectable(as:  CategoryDistributionRemoteDataSource)
class CategoryDistributionRemoteDataSourceImpl
    implements CategoryDistributionRemoteDataSource {
  final SupabaseService supabaseService;

  CategoryDistributionRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, List<CategoryDistributionEntity>>> getCategoryDistribution() async {
    try {
      if(NetworkUtils.hasInternet() == false) {
        return Left(Failures('No Internet Connection'));
      }
      final response = await supabaseService.supabaseClient
          .from('orders')
          .select('category')
          .neq('status', 'Pending');


      final data = response as List<dynamic>;

      if (data.isEmpty) {
        return const Right([]);
      }

      final Map<String, int> categoryCounts = {};

      for (var row in data) {
        final categoryName = row['category'] as String;
        categoryCounts[categoryName] = (categoryCounts[categoryName] ?? 0) + 1;
      }

      final total = data.length;

      final result = categoryCounts.entries.map((entry) {
        final percentage = (entry.value / total) * 100;
        return CategoryDistributionEntity(
          categoryName: entry.key,
          count: entry.value,
          percentage: percentage,
        );
      }).toList();

      return Right(result);
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }
}
