import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import '../../../../data_sources/remote/payments/pending_payments_remote_data_source/pending_payments_remote_data_source.dart';
import '../../../../models/payment_model/payment_model.dart';

@Injectable(as: PendingPaymentsRemoteDataSource)
class PendingPaymentsRemoteDataSourceImpl
    implements PendingPaymentsRemoteDataSource {
  final SupabaseService supabaseService;

  PendingPaymentsRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<PaymentEntity>>> getPendingPayments() async {
    try {
      if(NetworkUtils.hasInternet() == false ){
        return Left(Failures('No Internet Connection'));
      }
      final response = await supabaseService.supabaseClient
          .from('payments')
          .select('*')
          .eq('status', 'pending');

      if (response.isEmpty) {
        return const Right([]);
      }

      final payments =
      response.map<PaymentEntity>((e) => PaymentModel.fromJson(e)).toList();

      return Right(payments);
    } catch (e) {
      return Left(ServerFailure(  e.toString()));
    }
  }
}
