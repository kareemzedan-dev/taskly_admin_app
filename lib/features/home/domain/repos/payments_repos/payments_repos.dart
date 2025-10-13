import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

abstract class PaymentsRepository {
 
  Future<Either<Failures, List<PaymentEntity>>> getUserPayments({
    required String userId,
    required String role,  
  });

  Future<Either<Failures, List<PaymentEntity>>> getAllPayments();

  
  Future<RealtimeChannel> subscribePayments({
    required void Function(PaymentEntity payment, String action) onChange,
    String? userId, 
  });

 
  void unsubscribe(RealtimeChannel channel);
  Future<Either<Failures, void>> updatePaymentStatus( String paymentId, String status, String freelancerId, double amount);
 
}
