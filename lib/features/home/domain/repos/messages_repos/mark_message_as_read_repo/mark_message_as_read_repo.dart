import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';

abstract class MarkMessageAsReadRepo {
  Future<Either<Failures, void>> markMessagesAsRead(String orderId);

}