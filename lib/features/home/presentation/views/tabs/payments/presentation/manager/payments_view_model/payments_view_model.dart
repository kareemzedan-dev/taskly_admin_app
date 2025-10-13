import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:realtime_client/realtime_client.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/use_cases/get_all_payments_use_case/get_all_payments_use_case.dart';
import 'package:taskly_admin/features/home/domain/use_cases/subscribe_to_payments_use_case/subscribe_to_payments_use_case.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/manager/payments_view_model/payments_view_model_states.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';


@injectable
class PaymentsViewModel extends Cubit<PaymentsViewModelStates> {
  final GetAllPaymentsUseCase getAllPaymentsUseCase;
  final SubscribePaymentsUseCase subscribePaymentsUseCase;

  List<PaymentEntity> _payments = [];
  RealtimeChannel? _channel;

  PaymentsViewModel(
    this.getAllPaymentsUseCase,
    this.subscribePaymentsUseCase,
  ) : super(PaymentsInitialState());

  Future<void> loadPayments() async {
    if (!isClosed) { emit(PaymentsLoadingState()); }

    final result = await getAllPaymentsUseCase.call();
    result.fold(
      (failure) => emit(PaymentsErrorState(failure.message)),
      (payments) async {
        _payments = payments;
if (!isClosed) {
  emit(PaymentsSuccessState(List.from(_payments)));
}

        await _subscribeToRealtime();  
      },
    );
  }

  Future<void> _subscribeToRealtime() async {
 
    if (_channel != null) {
      subscribePaymentsUseCase.unsubscribe(_channel!);
      _channel = null;
    }

    _channel = await subscribePaymentsUseCase.call(
      onChange: (payment, action) {
        if (action == 'INSERT') {
          if (!_payments.any((p) => p.id == payment.id)) {
            _payments.add(payment);
          }
        } else if (action == 'UPDATE') {
          final idx = _payments.indexWhere((p) => p.id == payment.id);
          if (idx != -1) _payments[idx] = payment;
        } else if (action == 'DELETE') {
          _payments.removeWhere((p) => p.id == payment.id);
        }

        emit(PaymentsSuccessState(List.from(_payments)));
      },
    );
  }

  List<PaymentEntity> filterPayments({
    required bool isClient,
    required String status,
  }) {
    return _payments.where((p) {
      final requester = p.requesterType?.toLowerCase();
      final st = p.status.toLowerCase();

      if (isClient && requester != 'client') return false;
      if (!isClient && requester != 'freelancer') return false;
      if (st != status.toLowerCase()) return false;

      return true;
    }).toList();
  }

  int countPayments({
    required bool isClient,
    required String status,
  }) {
    return filterPayments(isClient: isClient, status: status).length;
  }

  @override
  Future<void> close() {
    if (_channel != null) {
      subscribePaymentsUseCase.unsubscribe(_channel!);
      _channel = null;
    }
    return super.close();
  }




}

extension PaymentsExporter on PaymentsViewModel {
  Future<void> exportPaymentsToCSV({bool shareFile = true}) async {
    try {
      final rows = <List<String>>[];

      // Header row
      rows.add([
        'Payment ID',
        'Amount',
        'Requester Type',
        'Status',
        'Created At',
        'Updated At',
        'Payment Method',
        'Account Number',
        'Order ID',
        'Attachments Count',
      ]);

      final formatter = DateFormat('yyyy-MM-dd HH:mm');

      for (final p in _payments) {
        rows.add([
          p.id,
          p.amount.toString(),
          p.requesterType ?? '',
          p.status,
          formatter.format(p.createdAt),
          formatter.format(p.updatedAt),
          p.paymentMethod ?? '',
          p.accountNumber ?? '',
          p.orderId ?? '',
          p.attachments.length.toString(),
        ]);
      }
      final csvData = const ListToCsvConverter().convert(rows);
      final bytes = Uint8List.fromList(utf8.encode(csvData));

      final savedFilePath = await FileSaver.instance.saveFile(
        name: 'payments_export',
        bytes: bytes,
        fileExtension: 'csv',
        mimeType: MimeType.csv,
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/payments_export.csv');
      await file.writeAsString(csvData);

      if (shareFile) {
        await Share.shareXFiles([XFile(file.path)], text: 'Payments Data Export');
      }

      print('✅ File saved successfully at: $savedFilePath');
    } catch (e) {
      print('❌ Export error: $e');
    }
  }
}

