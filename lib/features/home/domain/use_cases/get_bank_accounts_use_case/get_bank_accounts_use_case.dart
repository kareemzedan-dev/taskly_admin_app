import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/bank_account_repos/bank_account_repos.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetBankAccountsUseCase {
  final BankAccountsRepository repository;

  GetBankAccountsUseCase(this.repository);

  Future<Either<Failures, List<BankAccountsEntity>>> call() {
    return repository.getBankAccounts();
  }
}
