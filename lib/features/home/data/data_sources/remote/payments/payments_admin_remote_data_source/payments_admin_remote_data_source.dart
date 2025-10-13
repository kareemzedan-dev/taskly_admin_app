import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

abstract class PaymentsAdminRemoteDataSource {
  Future<Either<Failures, List<PaymentEntity>>> getAllPayments();
}
