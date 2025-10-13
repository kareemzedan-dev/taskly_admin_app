import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly_admin/core/errors/failures.dart';

import 'package:taskly_admin/features/home/domain/entities/payment_entity/payment_entity.dart';

import '../../../domain/repos/pending_payments_repo/pending_payments_repo.dart';
import '../../data_sources/remote/payments/pending_payments_remote_data_source/pending_payments_remote_data_source.dart';
@Injectable(as: PendingPaymentsRepo)
class PendingPaymentsRepoImpl implements PendingPaymentsRepo {
  final PendingPaymentsRemoteDataSource pendingPaymentsRemoteDataSource;
  PendingPaymentsRepoImpl(this.pendingPaymentsRemoteDataSource);

  @override
  Future<Either<Failures, List<PaymentEntity>>> getPendingPayments() {
     return pendingPaymentsRemoteDataSource.getPendingPayments();
  }

}