import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly_admin/core/errors/failures.dart';

import 'package:taskly_admin/features/home/domain/entities/category_distribution_entity/category_distribution_entity.dart';

import '../../../domain/repos/category_distribution_repo/category_distribution_repo.dart';
import '../../data_sources/remote/orders/category_distribution_remote_data_source/category_distribution_remote_data_source.dart';
@Injectable(as:  CategoryDistributionRepo)
class CategoryDistributionRepoImpl implements CategoryDistributionRepo {
  final CategoryDistributionRemoteDataSource categoryDistributionRemoteDataSource;
  CategoryDistributionRepoImpl({required this.categoryDistributionRemoteDataSource});

  @override
  Future<Either<Failures, List<CategoryDistributionEntity>>> getCategoryDistribution() {
    return categoryDistributionRemoteDataSource.getCategoryDistribution();
  }
}