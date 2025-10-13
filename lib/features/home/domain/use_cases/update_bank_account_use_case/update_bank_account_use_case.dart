import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/bank_account_repos/bank_account_repos.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateBankAccountUseCase {
  final BankAccountsRepository repository;

  UpdateBankAccountUseCase(this.repository);

  Future<Either<Failures, void>> call(BankAccountsEntity bankAccount) {
    return repository.updateBankAccount(bankAccount);
  }
}
