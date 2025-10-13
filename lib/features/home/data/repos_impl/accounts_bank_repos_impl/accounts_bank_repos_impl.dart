import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/models/bank_accounts_model/bank_accounts_model.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/domain/repos/bank_account_repos/bank_account_repos.dart';

import '../../data_sources/remote/payments/bank_accounts_remote_data_source/bank_accounts_remote_data_source.dart';

@Injectable(as: BankAccountsRepository)
class AccountsBankReposImpl implements BankAccountsRepository {
  final BankAccountsRemoteDataSource bankAccountsRemoteDataSource;

  AccountsBankReposImpl(this.bankAccountsRemoteDataSource);

  @override
  Future<Either<Failures, void>> addBankAccount(BankAccountsEntity entity) {
    final model = BankAccountsModel.fromEntity(entity);
    return bankAccountsRemoteDataSource.addBankAccountToRemote(model);
  }

  @override
  Future<Either<Failures, void>> deleteBankAccount(String id) {
    return bankAccountsRemoteDataSource.deleteBankAccountFromRemote(id);
  }

  @override
  Future<Either<Failures, List<BankAccountsEntity>>> getBankAccounts() async {
    final result = await bankAccountsRemoteDataSource.getBankAccountsFromRemote();

    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((m) => m.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failures, void>> updateBankAccount(BankAccountsEntity entity) {
    final model = BankAccountsModel.fromEntity(entity);
    return bankAccountsRemoteDataSource.updateBankAccountInRemote(model);
  }

  @override
  Future<Either<Failures, void>> updateBankAccountStatus(String id , bool status) {
    return bankAccountsRemoteDataSource.updateBankAccountStatusInRemote(id, status);
  }
}
