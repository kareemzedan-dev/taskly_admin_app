import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/cache/app_cache_manager.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/cache/app_cache_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../data_sources/remote/orders/get_all_orders_remote_data_source/get_all_orders_remote_data_source.dart';
import '../../../../data_sources/remote/orders/late_orders_remote_data_source/late_orders_remote_data_source.dart';
import '../../../../models/order_model/order_model.dart';

@Injectable(as: LateOrdersRemoteDataSource)
class LateOrdersRemoteDataSourceImpl implements LateOrdersRemoteDataSource {
  final SupabaseService supabaseService;
  static const cacheKey = 'late_orders';

  LateOrdersRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<OrderEntity>>> getLateOrders() async {
    try {
      // 1️⃣ حاول تجيب البيانات من الكاش
      final cachedFile = await AppCacheManager.instance.getFileFromCache(cacheKey);
      if (cachedFile != null) {
        final jsonString = await cachedFile.file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        final orders = jsonList
            .map((e) => OrderDm.fromJson(Map<String, dynamic>.from(e)).toEntity())
            .toList();
        return Right(orders);
      }

      // 2️⃣ لو مفيش انترنت
      if (!await NetworkUtils.hasInternet()) {
        return Left(Failures('No Internet Connection'));
      }

      // 3️⃣ جلب البيانات من Supabase
      final now = DateTime.now().toIso8601String();
      final response = await supabaseService.supabaseClient
          .from('orders')
          .select('*')
          .lt('deadline', now)
          .not('status', 'eq', 'Completed')
          .not('status', 'eq', 'Pending');

      if (response.isEmpty) {
        return const Right([]);
      }

      final orders = response.map<OrderEntity>((e) {
        final orderModel = OrderDm.fromJson(Map<String, dynamic>.from(e));
        return orderModel.toEntity();
      }).toList();

      // 4️⃣ خزّن البيانات في الكاش
      await AppCacheManager.instance.putFile(
        cacheKey,
        utf8.encode(jsonEncode(orders.map((e) => (e as OrderDm).toJson()).toList())),
        fileExtension: 'json',
      );

      return Right(orders);
    } catch (e, st) {
      print('Error fetching late orders: $e\n$st');
      return Left(ServerFailure('Failed to fetch late orders'));
    }
  }
}
