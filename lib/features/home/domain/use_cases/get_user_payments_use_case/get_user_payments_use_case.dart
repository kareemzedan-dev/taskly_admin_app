import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/payments_repos/payments_repos.dart';
@injectable
class GetUserPaymentsUseCase {
  final PaymentsRepository repository;

  GetUserPaymentsUseCase(this.repository);

  Future<Either<Failures, List<PaymentEntity>>> call({
    required String userId,
    required String role,
  }) async {
    return repository.getUserPayments(userId: userId, role: role);
  }
}
