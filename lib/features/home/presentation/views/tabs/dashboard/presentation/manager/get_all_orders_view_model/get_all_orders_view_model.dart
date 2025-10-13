import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/use_cases/get_all_orders_use_case/get_all_orders_use_case.dart';
import 'get_all_orders_states.dart';

@injectable
class GetAllOrdersViewModel extends Cubit<GetAllOrdersStates> {
  GetAllOrdersViewModel(this.getAllOrdersUseCase)
      : super(GetAllOrdersInitial());

  final GetAllOrdersUseCase getAllOrdersUseCase;

  Future<Either<Failures, List<OrderEntity>>> getAllOrders() async {
    try {
      emit(GetAllOrdersLoadingState());
      final result = await getAllOrdersUseCase.call();

      result.fold(
            (failure) => emit(GetAllOrdersErrorState(failure.message)),
            (orders) {
          final totalOrders = orders
          .where((order) => order.status.name.toLowerCase() == "completed")
          .length;


          final totalEarnings = orders
              .where((order) => order.status.name.toLowerCase() == "completed")
              .map((e) => e.budget ?? 0)
              .fold(0.0, (a, b) => a + b);

          emit(GetAllOrdersSuccessState(
            orders: orders,
            totalOrders: totalOrders,
            totalEarnings: totalEarnings,
          ));
        },
      );

      return result;
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }
}
extension OrdersExporter on GetAllOrdersViewModel {
  Future<void> exportOrdersToCSV() async {
    try {
      if (state is! GetAllOrdersSuccessState) return;

      final orders = (state as GetAllOrdersSuccessState).orders;

      final rows = <List<String>>[];
      rows.add([
        'ID',
        'Client ID',
        'Freelancer ID',
        'Title',
        'Description',
        'Category',
        'Service Type',
        'Budget',
        'Status',
        'Offers Count',
        'Deadline',
        'Created At',
        'Updated At',
        'Attachments'
      ]);

      for (final o in orders) {
        final attachmentLinks = o.attachments.map((a) => a.url ?? '').join('; ');
        rows.add([
          o.id,
          o.clientId,
          o.freelancerId ?? '',
          o.title,
          o.description ?? '',
          o.category ?? '',
          o.serviceType.name,
          o.budget?.toString() ?? '',
          o.status.name,
          o.offersCount?.toString() ?? '0',
          o.deadline?.toIso8601String() ?? '',
          o.createdAt.toIso8601String(),
          o.updatedAt.toIso8601String(),
          attachmentLinks
        ]);
      }

      final csvData = const ListToCsvConverter().convert(rows);
      final bytes = Uint8List.fromList(utf8.encode(csvData));

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/orders_export.csv');
      await file.writeAsBytes(bytes as List<int>);

      await Share.shareXFiles([XFile(file.path)], text: 'Orders Data Export');

      print('✅ Orders exported successfully');
    } catch (e) {
      print('❌ Export error: $e');
    }
  }
}
