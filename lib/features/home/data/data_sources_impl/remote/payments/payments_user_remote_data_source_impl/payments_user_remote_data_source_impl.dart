import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';
import 'package:taskly_admin/features/home/data/models/payment_model/payment_model.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import 'package:taskly_admin/features/attachments/data/models/attachments_dm/attachments_dm.dart';

import '../../../../data_sources/remote/payments/payments_user_remote_data_source/payments_user_remote_data_source.dart';
@Injectable(as: PaymentsUserRemoteDataSource)
class PaymentsUserRemoteDataSourceImpl implements PaymentsUserRemoteDataSource {
  final SupabaseService supabaseService;

  PaymentsUserRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<PaymentEntity>>> getUserPayments({
    required String role,
    required String userId,
  }) async {
    try {
      final column = role == 'freelancer' ? 'freelancer_id' : 'client_id';

      final response = await supabaseService.getDataFromSupabase(
        tableName: 'payments',
        filters: {column: userId},
      );

      final payments = (response as List).map((e) {
        final attachments = e['attachments'] != null
            ? (e['attachments'] as List)
                .map((a) => AttachmentModel.fromJson(a))
                .toList()
            : <AttachmentModel>[];
        return PaymentModel(
          id: e['id'],
          clientId: e['client_id'],
          freelancerId: e['freelancer_id'],
          orderId: e['order_id'],
          attachments: attachments,
          amount: (e['amount'] as num).toDouble(),
          status: e['status'],
          createdAt: DateTime.parse(e['created_at']),
          updatedAt: DateTime.parse(e['updated_at']),
          paymentMethod: e['payment_method'],
          accountNumber: e['account_number'],
          requesterType: e['requester_type'],
        );
      }).toList();

      return Right(payments);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
