import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/category_distribution_entity/category_distribution_entity.dart';
import '../../repos/category_distribution_repo/category_distribution_repo.dart';
@injectable
class CategoryDistributionUseCase {
  final CategoryDistributionRepo categoryDistributionRepo;
  CategoryDistributionUseCase({required this.categoryDistributionRepo});
  Future<Either<Failures, List<CategoryDistributionEntity>>> call() async {
    return await categoryDistributionRepo.getCategoryDistribution();
  }
}