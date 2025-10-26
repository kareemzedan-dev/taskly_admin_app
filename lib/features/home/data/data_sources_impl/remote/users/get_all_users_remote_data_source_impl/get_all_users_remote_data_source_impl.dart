import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../data_sources/remote/users/get_all_users_remote_data_source/get_all_users_remote_data_source.dart';
import '../../../../models/user_model/user_model.dart';

@Injectable(as: GetAllUsersRemoteDataSource)
class GetAllUsersRemoteDataSourceImpl extends GetAllUsersRemoteDataSource {
  final SupabaseService supabaseService;

  GetAllUsersRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<UserEntity>>> getAllUsers() async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure('No internet connection'));
      }

      // ================= users table =================
      final users = await supabaseService.getAll(table: 'users');

      final List<UserEntity> result = [];

      for (final user in users) {
        final role = user['role']?.toString() ?? '';

        Map<String, dynamic>? clientData;
        if (role == 'client' && user['id'] != null) {
          final clients = await supabaseService.getAll(
            table: 'clients',
            filters: {'id': user['id']},
          );
          if (clients.isNotEmpty) {
            clientData = Map<String, dynamic>.from(clients.first);
          }
        }

        Map<String, dynamic>? freelancerData;
        if (role == 'freelancer' && user['id'] != null) {
          final freelancers = await supabaseService.getAll(
            table: 'freelancers',
            filters: {'id': user['id']},
          );
          if (freelancers.isNotEmpty) {
            freelancerData = Map<String, dynamic>.from(freelancers.first);
          }
        }

        BillingInfo? billingInfo;
        if (clientData != null && clientData['billing_info'] != null) {
          billingInfo = _parseBillingInfo(clientData['billing_info']);
        }

        result.add(
          UserModel(
            id: user['id']?.toString() ?? '',
            fullName: user['full_name']?.toString() ?? '',
            email: user['email']?.toString() ?? '',
            phoneNumber: user['phone_number']?.toString() ?? '',
            role: role,
            profileImage: user['profile_image']?.toString() ?? '',
            bio: user['bio']?.toString() ?? '',

            createdAt: user['created_at'] != null
                ? DateTime.tryParse(user['created_at'].toString())
                : null,
            billingInfo: billingInfo,

            updatedAt: user['updated_at'] != null
                ? DateTime.tryParse(user['updated_at'].toString())
                : null,

            isOnline: user['is_online'] ?? false,
            rating: _parseDouble(user['rating']) ?? 0.0,
            balance: _parseDouble(clientData?['balance']) ?? 0.0,
            hourlyRate: _parseDouble(freelancerData?['hourly_rate']),
            freelancerBalance:
                _parseDouble(freelancerData?['freelancer_balance']) ?? 0.0,
            completedOrders:
                _parseDouble(user['completed_orders'])?.toDouble() ?? 0,
            totalOrders: _parseDouble(user['total_orders'])?.toDouble() ?? 0,

            jobsCount: user['jobs_count']?.toInt() ?? 0,
            lastSeen: user['last_seen'] != null
                ? DateTime.tryParse(user['last_seen'].toString())
                : null,
            reviewsCount: user['reviews_count']?.toInt() ?? 0,
            clientStatus: clientData?['client_status']?.toString() ?? '',
            freelancerStatus:
                freelancerData?['freelancer_status']?.toString() ?? '',
            isVerified: freelancerData?['is_verified'] ?? false,
            totalEarnings:
                _parseDouble(user['total_earnings'])?.toDouble() ?? 0,
          ),
        );
      }

      print("Fetched ${result.length} users");
      return Right(result);
    } catch (e, stackTrace) {
      print("Error fetching users: $e\n$stackTrace");
      return Left(ServerFailure('Failed to fetch users: $e'));
    }
  }

  BillingInfo? _parseBillingInfo(dynamic billingInfoData) {
    try {
      if (billingInfoData is Map<String, dynamic>) {
        return BillingInfo.fromJson(billingInfoData);
      } else if (billingInfoData is String) {
        final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(
          json.decode(billingInfoData),
        );
        return BillingInfo.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      print("Error parsing billing info: $e");
      return null;
    }
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

}
