import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
 

abstract class PaymentsUserRemoteDataSource {
  /// جلب كل طلبات الدفع الخاصة بالمستخدم
  Future<Either<Failures, List<PaymentEntity>>> getUserPayments({
    required String userId,
    required String role, // "client" أو "freelancer"
  });
}
