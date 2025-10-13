import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/offer_entity/offer_entity.dart';

import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../domain/repos/orders/orders_repos.dart';
import '../../data_sources/remote/offers/subscribe_to_offers_remote_data_source/subscribe_to_offers_remote_data_source.dart';
import '../../data_sources/remote/orders/subscribe_to_orders_remote_data_source/subscribe_to_orders_remote_data_source.dart';
import '../../data_sources/remote/users/get_user_info_by_id_data_source/get_user_info_by_id_data_source.dart';
@Injectable(as: OrdersRepos)
class OrdersReposImpl implements OrdersRepos {
  SubscribeToOrdersRemoteDataSource subscribeToOrdersRemoteDataSource;
  GetUserInfoByIdRemoteDataSource getUserInfoByIdRemoteDataSource ;
  SubscribeToOffersRemoteDataSource subscribeToOffersRemoteDataSource;
  OrdersReposImpl(this.subscribeToOrdersRemoteDataSource,this.getUserInfoByIdRemoteDataSource,this.subscribeToOffersRemoteDataSource);
  @override
  Future<Either<Failures, List<OrderEntity>>> getAllOrders() {
    // TODO: implement getAllOrders
    throw UnimplementedError();
  }

  @override
  Stream<List<OrderEntity>> orderRealtimeRepository() {
    return subscribeToOrdersRemoteDataSource.orderRealtimeRepository();



  }

  @override
  Future<Either<Failures, UserEntity>> getUserInfoById(String id) {
 return getUserInfoByIdRemoteDataSource.getUserInfoById(id);
  }

  @override
  Stream<List<OfferEntity>> offerRealtimeRepository(String orderId) {
   return subscribeToOffersRemoteDataSource.offerRealtimeRepository(orderId);
  }

}