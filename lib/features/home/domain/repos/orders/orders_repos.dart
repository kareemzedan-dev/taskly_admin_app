import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../entities/offer_entity/offer_entity.dart';

abstract class OrdersRepos {
  Stream<List<OrderEntity>> orderRealtimeRepository();
  Future<Either<Failures,List<OrderEntity>>> getAllOrders();
  Future<Either<Failures,UserEntity>> getUserInfoById(String id) ;
  Stream<List<OfferEntity>> offerRealtimeRepository(String orderId) ;

}