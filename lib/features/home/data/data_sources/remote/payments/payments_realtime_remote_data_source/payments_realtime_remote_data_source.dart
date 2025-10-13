import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

abstract class PaymentsRealtimeRemoteDataSource {
Future<RealtimeChannel>  subscribePayments({
    required void Function(PaymentEntity payment, String action) onChange,
    String? userId, 
  });

  void unsubscribe(RealtimeChannel channel);
}
