import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/orders/get_orders_conversions_remote_data_source/get_orders_conversions_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_orders_conversions_repo/get_orders_conversions_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:  GetOrdersConversionsRepo)
class GetOrdersConversionsRepoImpl implements GetOrdersConversionsRepo{
  final GetOrdersConversionsRemoteDataSource getOrdersConversationsRemoteDataSource;
  GetOrdersConversionsRepoImpl(this.getOrdersConversationsRemoteDataSource);

  @override
  Future<Either<Failures, List<OrderEntity>>> getOrdersConversations() {
    return getOrdersConversationsRemoteDataSource.getOrdersConversations();
  }
}