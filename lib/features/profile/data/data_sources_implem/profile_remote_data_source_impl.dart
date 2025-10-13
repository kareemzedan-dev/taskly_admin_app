
import 'package:either_dart/src/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/features/home/data/models/user_model/user_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/supabase_service.dart';
import '../data_sources/profile_remote_data_source.dart';
@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final SupabaseClient supabase;
  late final SupabaseService supabaseService;

  ProfileRemoteDataSourceImpl(this.supabase) {
    supabaseService = SupabaseService(supabase);
  }


    @override
    Future<Either<Failures, UserModel>> getUserInfo(
        String userId,

        ) async {
      try {

        final userResponse = await supabase
            .from('admins')
            .select()
            .eq('id', userId )
            .maybeSingle();




        final user = UserModel(
          id: userResponse?['id'] ?? "",
          fullName: userResponse?['full_name'] ?? "Unknown",
          email: userResponse?['email'] ?? "Unknown",
          phoneNumber: userResponse?['phone_number'] ?? "",
          role: userResponse?['role'] ?? "",
          profileImage: userResponse?['profile_image'],
          bio: userResponse?['bio'],
          createdAt: userResponse?['created_at'] != null
              ? DateTime.tryParse(userResponse!['created_at'])
              : null,
          rating: userResponse?['rating'] != null
              ? (userResponse!['rating'] as num).toDouble()
              : 1.0,
          completedOrders:  userResponse?['completed_orders'] != null
            ? (userResponse!['completed_orders'] as num).toDouble()
              : 0,
           totalOrders:  userResponse?['total_orders'] != null
             ? (userResponse!['total_orders'] as num).toDouble()
             : 0,
           totalEarnings:  userResponse?['total_earnings'] != null
            ? (userResponse!['total_earnings'] as num).toDouble()
                : 0,

        );



        return Right(user);
      } catch (e) {
        debugPrint("Failed to fetch user info: $e");
        return Left(ServerFailure("Failed to fetch user info: $e"));

      }
    }


}