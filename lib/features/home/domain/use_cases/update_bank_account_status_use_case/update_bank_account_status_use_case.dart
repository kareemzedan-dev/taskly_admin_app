import 'package:either_dart/either.dart';
 
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/repos/bank_account_repos/bank_account_repos.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateBankAccountStatusUseCase {
  final BankAccountsRepository repository;

  UpdateBankAccountStatusUseCase(this.repository);

  Future<Either<Failures, void>> call(String id , bool status) {
    return repository.updateBankAccountStatus(id , status);
  }
}
