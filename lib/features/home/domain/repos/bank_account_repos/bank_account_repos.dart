
import 'package:either_dart/either.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';

abstract class BankAccountsRepository {
  Future<Either<Failures, List<BankAccountsEntity>>> getBankAccounts();
  Future<Either<Failures, void>> addBankAccount(BankAccountsEntity bankAccountsEntity);
  Future<Either<Failures, void>> deleteBankAccount(String id);
  Future<Either<Failures, void>> updateBankAccount(BankAccountsEntity bankAccountsEntity);
  Future<Either<Failures, void>> updateBankAccountStatus(String id , bool status);
}
