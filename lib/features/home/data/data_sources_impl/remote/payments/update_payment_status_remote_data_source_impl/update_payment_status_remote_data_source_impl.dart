import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import '../../../../data_sources/remote/payments/update_payment_status_remote_data_source/update_payment_status_remote_data_source.dart';
@Injectable(as: UpdatePaymentStatusRemoteDataSource)
class UpdatePaymentStatusRemoteDataSourceImpl extends UpdatePaymentStatusRemoteDataSource {
  final SupabaseService _supabaseService;

  UpdatePaymentStatusRemoteDataSourceImpl(this._supabaseService);

  @override
  Future<Either<Failures, void>> updatePaymentStatus({
    required String paymentId,
    required String status,
    required String freelancerId,
    required double amount,
  }) async {
    try {
      print("🔹 Checking internet...");
      if (!await NetworkUtils.hasInternet()) {
        print("❌ No internet connection");
        return Left(NetworkFailure('No internet connection'));
      }

      print("🔹 Updating payment status for paymentId: $paymentId to $status");
      final paymentUpdateResponse = await _supabaseService.supabaseClient
          .from('payments')
          .update({'status': status})
          .eq('id', paymentId);
      print("✅ Payment status updated: $paymentUpdateResponse");

      print("🔹 Fetching freelancer balance for freelancerId: $freelancerId");
      final List<Map<String, dynamic>> freelancerData = await _supabaseService.supabaseClient
          .from('freelancers')
          .select('freelancer_balance')
          .eq('id', freelancerId);
      print("✅ Freelancer data fetched: $freelancerData");

      if (freelancerData.isEmpty) {
        print("❌ Freelancer not found");
        return Left(ServerFailure('Freelancer not found'));
      }

      final currentBalance = (freelancerData.first['freelancer_balance'] ?? 0).toDouble();
      final newBalance = currentBalance - amount;
      print("🔹 Current balance: $currentBalance, New balance after deduction: $newBalance");

      if (newBalance < 0) {
        print("❌ Insufficient balance");
        return Left(ServerFailure('Insufficient balance'));
      }

      print("🔹 Updating freelancer balance...");
      final freelancerUpdateResponse = await _supabaseService.supabaseClient
          .from('freelancers')
          .update({'freelancer_balance': newBalance})
          .eq('id', freelancerId);
      print("✅ Freelancer balance updated: $freelancerUpdateResponse");

      return const Right(null);
    } catch (e, st) {
      print("❌ Exception caught: $e");
      print(st);
      return Left(ServerFailure(e.toString()));
    }
  }
}
