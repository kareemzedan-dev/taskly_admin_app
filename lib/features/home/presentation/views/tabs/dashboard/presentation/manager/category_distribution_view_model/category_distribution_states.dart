import '../../../../../../../domain/entities/category_distribution_entity/category_distribution_entity.dart';

class CategoryDistributionStates {}
class CategoryDistributionInitial extends CategoryDistributionStates {}

class CategoryDistributionLoadingState extends CategoryDistributionStates {}

class CategoryDistributionLoadedState extends CategoryDistributionStates {
  final List<CategoryDistributionEntity> categoryDistribution;
  CategoryDistributionLoadedState({required this.categoryDistribution});
}

class CategoryDistributionErrorState extends CategoryDistributionStates {
  final String message;
  CategoryDistributionErrorState({required this.message});
}