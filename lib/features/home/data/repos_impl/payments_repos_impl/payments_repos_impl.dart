import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:realtime_client/src/realtime_channel.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/payments_repos/payments_repos.dart';

import '../../data_sources/remote/payments/payments_admin_remote_data_source/payments_admin_remote_data_source.dart';
import '../../data_sources/remote/payments/payments_realtime_remote_data_source/payments_realtime_remote_data_source.dart';
import '../../data_sources/remote/payments/payments_user_remote_data_source/payments_user_remote_data_source.dart';
import '../../data_sources/remote/payments/update_payment_status_remote_data_source/update_payment_status_remote_data_source.dart';
@Injectable(as: PaymentsRepository)
class PaymentsReposImpl extends PaymentsRepository{
  PaymentsAdminRemoteDataSource paymentsAdminRemoteDataSource;
  PaymentsUserRemoteDataSource paymentsUserRemoteDataSource;
  PaymentsRealtimeRemoteDataSource paymentsRealtimeRemoteDataSource;
  UpdatePaymentStatusRemoteDataSource updatePaymentStatusRemoteDataSource;
  PaymentsReposImpl(this.paymentsAdminRemoteDataSource , this.paymentsUserRemoteDataSource,  this.updatePaymentStatusRemoteDataSource,this.paymentsRealtimeRemoteDataSource);
  @override
  Future<Either<Failures, List<PaymentEntity>>> getAllPayments() {
    return paymentsAdminRemoteDataSource.getAllPayments();
  }

  @override
  Future<Either<Failures, List<PaymentEntity>>> getUserPayments({required String userId, required String role}) {
  return paymentsUserRemoteDataSource.getUserPayments(userId: userId, role: role);
  }

  @override
  Future<RealtimeChannel> subscribePayments({required void Function(PaymentEntity payment, String action) onChange, String? userId}) {
    return paymentsRealtimeRemoteDataSource.subscribePayments(onChange: onChange, userId: userId);
  }

  @override
  void unsubscribe(RealtimeChannel channel) {
   return paymentsRealtimeRemoteDataSource.unsubscribe(channel);
  }
  
  @override
  Future<Either<Failures, void>> updatePaymentStatus(String paymentId, String status ,String freelancerId, double amount) {
    return updatePaymentStatusRemoteDataSource.updatePaymentStatus(paymentId: paymentId, status: status, freelancerId: freelancerId, amount: amount);
     
  }

}