
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';

@injectable
abstract class UpdatePaymentStatusRemoteDataSource {
  Future<Either<Failures, void>> updatePaymentStatus({required String paymentId,required String status, required String freelancerId, required double amount});
}