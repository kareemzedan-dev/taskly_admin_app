import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';

import '../../../../data_sources/remote/users/update_user_status_remote_data_source/update_user_status_remote_data_source.dart';

@Injectable(as: UpdateUserStatusRemoteDataSource)
class UpdateUserStatusRemoteDataSourceImpl implements UpdateUserStatusRemoteDataSource {
  final SupabaseService _supabaseService;

  UpdateUserStatusRemoteDataSourceImpl(this._supabaseService);

  @override
  Future<void> updateUserStatus(
    String userId,
    {String? status, bool? isVerified, required String role}
  ) async {
    try {
      final table = role.toLowerCase() == 'client' ? 'clients' : 'freelancers';
      final Map<String, dynamic> data = {};

      if (status != null) {
        final statusColumn = role.toLowerCase() == 'client'
            ? 'client_status'
            : 'freelancer_status';
        data[statusColumn] = status;
      }

      if (isVerified != null && role.toLowerCase() == 'freelancer') {
        data['is_verified'] = isVerified;
      }

      if (data.isEmpty) {
        print("⚠️ No fields to update for user $userId");
        return;
      }

      print("Updating $table for user $userId with data: $data");

      await _supabaseService.update(
        table: table,
        id: userId,
        data: data,
      );
    } catch (e) {
      print("❌ Failed to update user: $e");
      rethrow;
    }
  }
}
