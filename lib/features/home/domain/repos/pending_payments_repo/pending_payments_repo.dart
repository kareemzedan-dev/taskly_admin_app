import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/payment_entity/payment_entity.dart';

abstract class PendingPaymentsRepo {
   Future<Either<Failures, List<PaymentEntity>>> getPendingPayments();
}