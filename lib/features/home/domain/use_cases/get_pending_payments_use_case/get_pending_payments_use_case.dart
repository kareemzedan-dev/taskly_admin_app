import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/payment_entity/payment_entity.dart';
import '../../repos/pending_payments_repo/pending_payments_repo.dart';
@injectable
class GetPendingPaymentsUseCase {
  final PendingPaymentsRepo pendingPaymentsRepo;
  GetPendingPaymentsUseCase(this.pendingPaymentsRepo);
  Future<Either<Failures, List<PaymentEntity>>> call() async {
    return await pendingPaymentsRepo.getPendingPayments();
  }
}