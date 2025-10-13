import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/data/models/bank_accounts_model/bank_accounts_model.dart';

import '../../../../data_sources/remote/payments/bank_accounts_remote_data_source/bank_accounts_remote_data_source.dart';

@Injectable(as: BankAccountsRemoteDataSource)
class BankAccountsRemoteDataSourceImpl implements BankAccountsRemoteDataSource {
  final SupabaseService service;

  BankAccountsRemoteDataSourceImpl(this.service);

  @override
  Future<Either<Failures, List<BankAccountsModel>>> getBankAccountsFromRemote() async {
    try {
      final List<Map<String, dynamic>> response =
          await service.getAll(table: 'bank_accounts');

      final accounts =
          response.map((json) => BankAccountsModel.fromJson(json)).toList();

      return Right(accounts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> addBankAccountToRemote(BankAccountsModel model) async {
    try {
      await service.upsert(
        table: 'bank_accounts',
        data: model.toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteBankAccountFromRemote(String id) async {
    try {
      await service.delete(
        table: 'bank_accounts',
        id: id,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateBankAccountInRemote(BankAccountsModel model) async {
    try {
      if (model.id == null) {
        return Left(ServerFailure('Bank account ID is required for update'));
      }

      await service.update(
        table: 'bank_accounts',
        id: model.id!,
        data: model.toJson(),
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateBankAccountStatusInRemote(String id, bool isActive) async {
    try {
      await service.update(
        table: 'bank_accounts',
        id: id,
        data: {'is_active': isActive},
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
