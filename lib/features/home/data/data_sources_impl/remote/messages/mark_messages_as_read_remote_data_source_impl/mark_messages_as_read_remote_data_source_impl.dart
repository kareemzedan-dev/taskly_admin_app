

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/core/utils/network_utils.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/mark_messages_as_read_remote_data_source_impl/mark_messages_as_read_remote_data_source.dart';
@Injectable(as:  MarkMessagesAsReadRemoteDataSource)
class MarkMessagesAsReadRemoteDataSourceImpl implements MarkMessagesAsReadRemoteDataSource {
  final SupabaseService supabaseService ;

  MarkMessagesAsReadRemoteDataSourceImpl(this.supabaseService);
  @override
  Future<Either<Failures, void>> markMessagesAsRead(String orderId) async {
    try {
      if(!await NetworkUtils.hasInternet()){
        return Left(ServerFailure('No internet connection'));
      }
      await supabase.from('messages').update({'is_read': true}).eq('order_id', orderId);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}