import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/orders/update_order_status_remote_data_source/update_order_status_remote_data_source.dart';
@Injectable(as: UpdateOrderStatusRemoteDataSource)
class UpdateOrderStatusRemoteDataSourceImpl implements UpdateOrderStatusRemoteDataSource {
  final SupabaseService _supabaseService;
  UpdateOrderStatusRemoteDataSourceImpl(this._supabaseService);

  @override
  Future<Either<Failures, void>> updateOrderStatus(
      String orderId, String status) async {
    try {
      final updateData = <String, dynamic>{'status': status};


      if (status == 'In Progress') {
        updateData['work_started'] = DateTime.now().toIso8601String();
      }

      await _supabaseService.supabaseClient
          .from('orders')
          .update(updateData)
          .eq('id', orderId);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update order status: $e'));
    }
  }
}
