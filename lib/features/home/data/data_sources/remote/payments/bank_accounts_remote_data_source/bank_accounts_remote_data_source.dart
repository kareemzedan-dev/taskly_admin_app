
import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/data/models/bank_accounts_model/bank_accounts_model.dart';

abstract class BankAccountsRemoteDataSource {
  Future<Either<Failures, List<BankAccountsModel>>> getBankAccountsFromRemote();
  Future<Either<Failures, void>> addBankAccountToRemote(BankAccountsModel model);
  Future<Either<Failures, void>> deleteBankAccountFromRemote(String id);
  Future<Either<Failures, void>> updateBankAccountInRemote(BankAccountsModel model);
  Future<Either<Failures, void>> updateBankAccountStatusInRemote(String id, bool isActive);
}
