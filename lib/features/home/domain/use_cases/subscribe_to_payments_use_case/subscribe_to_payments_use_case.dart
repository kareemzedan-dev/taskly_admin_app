import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/payments_repos/payments_repos.dart';
@injectable
class SubscribePaymentsUseCase {
  final PaymentsRepository repository;

  SubscribePaymentsUseCase(this.repository);

  Future<RealtimeChannel> call({
    required void Function(PaymentEntity payment, String action) onChange,
    String? userId, 
  }) async {
    return repository.subscribePayments(onChange: onChange, userId: userId);
  }

  void unsubscribe(RealtimeChannel channel) {
    repository.unsubscribe(channel);
  }
}
