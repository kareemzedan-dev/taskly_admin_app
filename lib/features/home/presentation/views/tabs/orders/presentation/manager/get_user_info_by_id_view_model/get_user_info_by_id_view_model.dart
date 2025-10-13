import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';

import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../../../../../../domain/use_cases/get_user_info_by_id_use_case/get_user_info_by_id_use_case.dart';
import 'get_user_info_by_id_states.dart';
@injectable
@factoryMethod
class GetUserInfoByIdViewModel extends Cubit<GetUserInfoByIdStates> {
  final GetUserInfoByIdUseCase getuserInfoByIdUseCase;

  // ---------------- Cache داخلي ----------------
  final Map<String, UserEntity> _userCache = {};

  GetUserInfoByIdViewModel(this.getuserInfoByIdUseCase)
      : super(GetUserInfoByIdInitial());

  Future<Either<Failures, UserEntity>> getUserInfoById(String id) async {
    try {

      if (_userCache.containsKey(id)) {
        final cachedUser = _userCache[id]!;
        emit(GetUserInfoByIdSuccess(cachedUser));
        return Right(cachedUser);
      }

      emit(GetUserInfoByIdLoading());

      final result = await getuserInfoByIdUseCase.call(id);

      result.fold(
            (failure) => emit(GetUserInfoByIdError(failure.message)),
            (user) {

          _userCache[id] = user;
          emit(GetUserInfoByIdSuccess(user));
        },
      );

      return result;
    } catch (e) {
      return Left(ServerFailure('Failed to fetch user info: $e'));
    }
  }
}
