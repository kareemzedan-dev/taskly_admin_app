import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/payment_entity/payment_entity.dart';

abstract class PendingPaymentsRemoteDataSource {
  Future<Either<Failures, List<PaymentEntity>>> getPendingPayments();
}