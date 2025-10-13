import 'dart:convert'; // ⬅ مهم عشان jsonDecode
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/attachments/data/models/attachments_dm/attachments_dm.dart';
import 'package:taskly_admin/features/home/data/models/payment_model/payment_model.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

import '../../../../data_sources/remote/payments/payments_admin_remote_data_source/payments_admin_remote_data_source.dart';

@Injectable(as: PaymentsAdminRemoteDataSource)
class PaymentsAdminRemoteDataSourceImpl
    implements PaymentsAdminRemoteDataSource {
  final SupabaseService supabaseService;

  PaymentsAdminRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<PaymentEntity>>> getAllPayments() async {
    try {
      final response = await supabaseService.getAll(
        table: 'payments',
      );

      final payments = (response as List).map((e) {

        List<AttachmentModel> attachments = [];
        if (e['attachments'] != null) {
          if (e['attachments'] is String) {
            try {
              final decoded = jsonDecode(e['attachments']);
              if (decoded is List) {
                attachments =
                    decoded.map((a) => AttachmentModel.fromJson(a)).toList();
              }
            } catch (_) {
              attachments = [];
            }
          } else if (e['attachments'] is List) {
            attachments =
                (e['attachments'] as List).map((a) => AttachmentModel.fromJson(a)).toList();
          }
        }

        return PaymentModel(
          id: e['id'] as String,
          clientId: e['client_id'] as String?,
          freelancerId: e['freelancer_id'] as String?,
          orderId: e['order_id'] as String?,
          attachments: attachments,
          amount: (e['amount'] as num).toDouble(),
          status: e['status'] as String,
          createdAt: DateTime.parse(e['created_at'] as String),
          updatedAt: DateTime.parse(e['updated_at'] as String),
          paymentMethod: e['payment_method'] as String?,
          accountNumber: e['account_number'] as String?,
          requesterType: e['requester_type'] as String?,
        );
      }).toList();

      return Right(payments);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
