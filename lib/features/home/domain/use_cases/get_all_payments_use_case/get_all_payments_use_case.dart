import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/payments_repos/payments_repos.dart';
@injectable
class GetAllPaymentsUseCase {
  final PaymentsRepository repository;

  GetAllPaymentsUseCase(this.repository);

  Future<Either<Failures, List<PaymentEntity>>> call() async {
    return repository.getAllPayments();
  }
}
