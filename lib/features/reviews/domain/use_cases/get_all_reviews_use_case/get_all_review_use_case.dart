import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly_admin/features/reviews/domain/repositories/reviews_repo/reviews_repo.dart';
@injectable

class GetAllReviewsUseCase {
  final ReviewsRepo repo;

  GetAllReviewsUseCase(this.repo);

  Future<Either<Failures, List<ReviewsEntity>>> call() async {
    return await repo.getAllReviews();
  }
}
