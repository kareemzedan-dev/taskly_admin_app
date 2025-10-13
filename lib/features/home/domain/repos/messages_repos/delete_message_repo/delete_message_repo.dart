import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';

abstract class DeleteMessageRepo {
  Future<Either<Failures, void>> deleteMessage(String messageId);

}