import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/reviews/data/data_sources/remote/reviews_remote_data_source/reviews_remote_data_source.dart';
import 'package:taskly_admin/features/reviews/data/models/reviews_model/reviews_model.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
@Injectable(as: ReviewsRemoteDataSource)
class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  final SupabaseClient supabase;

  ReviewsRemoteDataSourceImpl(this.supabase);

  @override
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({
    required String userId,
    required String role,
  }) async {
    try {
      final response = await supabase
          .from('reviews')
          .select()
          .eq(role == 'client' ? 'client_id' : 'freelancer_id', userId);

      final data = response as List;
      return Right(
        data
            .map((json) => ReviewsModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ReviewsEntity>>> getAllReviews() async {
    try {
      final response = await supabase.from('reviews').select();
      final data = response as List;
      return Right(
        data
            .map((json) => ReviewsModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteReview(String reviewId) async {
    try {
      await supabase.from('reviews').delete().eq('id', reviewId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
