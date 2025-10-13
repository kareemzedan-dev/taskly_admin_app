import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/category_distribution_entity/category_distribution_entity.dart';

abstract class CategoryDistributionRepo {
  Future<Either<Failures, List<CategoryDistributionEntity>>> getCategoryDistribution();
}