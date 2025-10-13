import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/category_distribution_entity/category_distribution_entity.dart';

abstract class CategoryDistributionRemoteDataSource {
  Future<Either<Failures, List<CategoryDistributionEntity>>> getCategoryDistribution();
}