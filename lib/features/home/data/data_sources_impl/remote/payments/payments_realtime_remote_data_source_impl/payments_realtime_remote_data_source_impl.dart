import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/data/models/payment_model/payment_model.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

import '../../../../data_sources/remote/payments/payments_realtime_remote_data_source/payments_realtime_remote_data_source.dart';

@Injectable(as: PaymentsRealtimeRemoteDataSource)
class PaymentsRealtimeRemoteDataSourceImpl
    implements PaymentsRealtimeRemoteDataSource {
  final SupabaseService supabaseService;

  PaymentsRealtimeRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<RealtimeChannel> subscribePayments({
    required void Function(PaymentEntity payment, String action) onChange,
    String? userId,
  }) async {
    final channel = supabaseService.supabaseClient.channel('payments');

    debugPrint("🚀 Trying to subscribe to payments channel...");

    // Insert
    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'payments',
      callback: (payload) {
        final record = payload.newRecord;
        debugPrint("📩 INSERT payload => $record");

        if (userId != null &&
            record['freelancer_id'] != userId &&
            record['client_id'] != userId) {
          debugPrint("⏭️ Skipped INSERT because userId mismatch");
          return;
        }

        final payment = PaymentModel(
          id: record['id'].toString(), // 👈 مهم نخليها String
          clientId: record['client_id'],
          freelancerId: record['freelancer_id'],
          orderId: record['order_id'],
          attachments: [],
          amount: (record['amount'] as num).toDouble(),
          status: record['status'],
          createdAt: DateTime.parse(record['created_at']),
          updatedAt: DateTime.parse(record['updated_at']),
          paymentMethod: record['payment_method'],
          accountNumber: record['account_number'],
          requesterType: record['requester_type'],
        );

        debugPrint("📥 INSERT Payment => ${payment.id}, status: ${payment.status}");
        onChange(payment, 'INSERT');
      },
    );

    // Update
    channel.onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'payments',
      callback: (payload) {
        final record = payload.newRecord;
        debugPrint("📩 UPDATE payload => $record");

        final payment = PaymentModel(
          id: record['id'].toString(),
          clientId: record['client_id'],
          freelancerId: record['freelancer_id'],
          orderId: record['order_id'],
          attachments: [],
          amount: (record['amount'] as num).toDouble(),
          status: record['status'],
          createdAt: DateTime.parse(record['created_at']),
          updatedAt: DateTime.parse(record['updated_at']),
          paymentMethod: record['payment_method'],
          accountNumber: record['account_number'],
          requesterType: record['requester_type'],
        );

        debugPrint("✏️ UPDATE Payment => ${payment.id}, status: ${payment.status}");
        onChange(payment, 'UPDATE');
      },
    );

   // Delete
channel.onPostgresChanges(
  event: PostgresChangeEvent.delete,
  schema: 'public',
  table: 'payments',
  callback: (payload) {
    final record = payload.oldRecord;
    debugPrint("📩 DELETE payload => $record");

    final payment = PaymentModel(
      id: record['id'].toString(),
      clientId: record['client_id'] ?? '',
      freelancerId: record['freelancer_id'] ?? '',
      orderId: record['order_id'] ?? '',
      attachments: [],
      amount: (record['amount'] != null)
          ? (record['amount'] as num).toDouble()
          : 0.0, // 👈 حل مشكلة الـ null
      status: record['status'] ?? 'deleted',
      createdAt: record['created_at'] != null
          ? DateTime.parse(record['created_at'])
          : DateTime.now(),
      updatedAt: record['updated_at'] != null
          ? DateTime.parse(record['updated_at'])
          : DateTime.now(),
      paymentMethod: record['payment_method'] ?? '',
      accountNumber: record['account_number'] ?? '',
      requesterType: record['requester_type'] ?? '',
    );

    debugPrint("🗑️ DELETE Payment => ${payment.id}");
    onChange(payment, 'DELETE');
  },
);


    final result = channel.subscribe();
    debugPrint("📡 Channel subscribe result: $result");
    debugPrint("📡 Channel state: ${channel.presence}");

    return channel;
  }

  @override
  void unsubscribe(RealtimeChannel channel) {
    supabaseService.supabaseClient.removeChannel(channel);
    debugPrint("❌ Payments Realtime Channel unsubscribed!");
  }
}
