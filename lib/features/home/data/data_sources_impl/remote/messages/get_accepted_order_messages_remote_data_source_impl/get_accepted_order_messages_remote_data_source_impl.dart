import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/cache/app_cache_manager.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/models/order_model/order_model.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart';

import '../../../../data_sources/remote/messages_remote_data_sources/get_accepted_order_messages_remote_data_source/get_accepted_order_messages_remote_data_source.dart';

@Injectable(as: GetAcceptedOrderMessagesRemoteDataSource)
class GetAcceptedOrderMessagesRemoteDataSourceImpl
    implements GetAcceptedOrderMessagesRemoteDataSource {
  final SupabaseService supabaseService;

  GetAcceptedOrderMessagesRemoteDataSourceImpl(this.supabaseService);

  static const acceptedOrdersCachePrefix = 'accepted_order_messages_';
  @override
  Future<Either<Failures, List<OrderEntity>>> getAllOrdersMessages(
    String userId,
    UserRole role,
  ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(ServerFailure('No internet connection'));
      }

      final cacheKey = '$acceptedOrdersCachePrefix$userId';

      final cachedFile = await AppCacheManager.instance.getFileFromCache(
        cacheKey,
      );
      if (cachedFile != null) {
        final jsonString = await cachedFile.file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        final orders =
            jsonList
                .map(
                  (e) =>
                      OrderDm.fromJson(Map<String, dynamic>.from(e)).toEntity(),
                )
                .toList();
        return Right(orders);
      }

      final column =
          role == UserRole.freelancer ? 'freelancer_id' : 'client_id';
      final response = await supabase
          .from('orders')
          .select()
          .eq(column, userId);
         

      final orders =
          (response as List)
              .map(
                (e) =>
                    OrderDm.fromJson(Map<String, dynamic>.from(e)).toEntity(),
              )
              .toList();

      await AppCacheManager.instance.putFile(
        cacheKey,
        utf8.encode(
          jsonEncode(orders.map((e) => (e as OrderDm).toJson()).toList()),
        ),
        fileExtension: 'json',
      );

      return Right(orders);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
