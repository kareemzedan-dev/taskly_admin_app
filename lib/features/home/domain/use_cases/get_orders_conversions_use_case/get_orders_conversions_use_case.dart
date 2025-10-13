import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/messages_repos/get_orders_conversions_repo/get_orders_conversions_repo.dart';

@injectable
class GetOrdersConversionsUseCase {
  GetOrdersConversionsRepo repos;
  GetOrdersConversionsUseCase(this.repos);
  Future<Either<Failures, List<OrderEntity>>> call() {
    return repos.getOrdersConversations();
  }
}