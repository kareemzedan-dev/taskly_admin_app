import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/repos/payments_repos/payments_repos.dart';
@injectable
class UpdatePaymentStatusUseCase {
  PaymentsRepository paymentsRepository;
  UpdatePaymentStatusUseCase(this.paymentsRepository);
  Future<Either<Failures, void>> call(String paymentId , String status , String freelancerId, double amount) => paymentsRepository.updatePaymentStatus(
    paymentId,
     status,
     freelancerId,
    amount
  );
}