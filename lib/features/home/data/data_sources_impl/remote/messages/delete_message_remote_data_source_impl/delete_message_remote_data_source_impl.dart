import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/delete_message_remote_data_source/delete_message_remote_data_source.dart';
@Injectable(as:  DeleteMessageRemoteDataSource)
class DeleteMessageRemoteDataSourceImpl implements DeleteMessageRemoteDataSource{
  final SupabaseService supabaseService;

  DeleteMessageRemoteDataSourceImpl(this.supabaseService);
  @override
  Future<Either<Failures, void>> deleteMessage(String messageId) async {
    try {
      if(!await NetworkUtils.hasInternet()){
        return Left(ServerFailure('No internet connection'));
      }
      await supabaseService.supabaseClient.from('messages').delete().eq('id', messageId);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}