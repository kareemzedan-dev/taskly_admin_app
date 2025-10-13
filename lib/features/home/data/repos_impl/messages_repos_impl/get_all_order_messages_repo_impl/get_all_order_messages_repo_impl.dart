import 'package:either_dart/src/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/get_accepted_order_messages_remote_data_source/get_accepted_order_messages_remote_data_source.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/orders/get_all_orders_remote_data_source/get_all_orders_remote_data_source.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/orders/get_orders_conversions_remote_data_source/get_orders_conversions_remote_data_source.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_all_order_messages_repo/get_all_order_messages_repo.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:  GetAllOrderMessagesRepo)
class GetAllOrderMessagesRepoImpl implements GetAllOrderMessagesRepo{

  GetAllOrderMessagesRepoImpl(this.getOrdersConversationsRemoteDataSource);

  final GetAcceptedOrderMessagesRemoteDataSource getOrdersConversationsRemoteDataSource;

  @override
  Future<Either<Failures, List<OrderEntity>>> getAllOrderMessages(String userId, UserRole role) {
    return getOrdersConversationsRemoteDataSource.getAllOrdersMessages(userId, role );
  }

}