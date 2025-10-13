import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/users/get_user_info_by_id_data_source/get_user_info_by_id_data_source.dart';
import '../../../../models/user_model/user_model.dart';
@Injectable(as:  GetUserInfoByIdRemoteDataSource)
class GetUserInfoByIdRemoteDataSourceImpl implements GetUserInfoByIdRemoteDataSource {
  final SupabaseService supabaseService;
  GetUserInfoByIdRemoteDataSourceImpl(this.supabaseService);
  @override
  Future<Either<Failures, UserEntity>> getUserInfoById(String id) async {
    try {

      final users = await supabaseService.getAll(
        table: 'users',
        filters: {'id': id},
      );

      if (users.isEmpty) {
        return Left(ServerFailure('User not found'));
      }

      final user = users.first;
      final role = user['role']?.toString() ?? '';

      Map<String, dynamic>? clientData;
      Map<String, dynamic>? freelancerData;

      if (role == 'client') {
        final clients = await supabaseService.getAll(
          table: 'clients',
          filters: {'id': id},
        );
        if (clients.isNotEmpty) {
          clientData = Map<String, dynamic>.from(clients.first);
        }
      } else if (role == 'freelancer') {
        final freelancers = await supabaseService.getAll(
          table: 'freelancers',
          filters: {'id': id},
        );
        if (freelancers.isNotEmpty) {
          freelancerData = Map<String, dynamic>.from(freelancers.first);
        }
      }

      BillingInfo? billingInfo;
      if (clientData != null && clientData['billing_info'] != null) {
        billingInfo = _parseBillingInfo(clientData['billing_info']);
      }

      final userEntity = UserModel(
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
        skills: freelancerData != null ? _parseSkills(freelancerData['skills']) : null,
       freelancerStatus:  freelancerData?['freelancer_status'] ?? '',
       clientStatus:  clientData?['client_status'] ?? '',
        isVerified: freelancerData?['is_verified'] ?? false,
        isOnline: user['is_online'] ?? false,
        jobsCount: user['jobs_count']?.toInt() ?? 0,
        lastSeen: user['last_seen'] != null
            ? DateTime.tryParse(user['last_seen'].toString())
            : null,
        reviewsCount: user['reviews_count']?.toInt() ?? 0,
        rating: _parseDouble(user['rating']) ?? 0.0,
        totalEarnings: _parseDouble(user['total_earnings']) ?? 0.0,
        completedOrders: _parseDouble(user['completed_orders'])?.toDouble() ?? 0,
        totalOrders: _parseDouble(user['total_orders'])?.toDouble() ?? 0,
        balance: _parseDouble(clientData?['balance']) ?? 0.0,
        hourlyRate: _parseDouble(freelancerData?['hourly_rate']),
        freelancerBalance: _parseDouble(freelancerData?['freelancer_balance']) ?? 0.0,

      );

      return Right(userEntity);
    } catch (e, st) {
      print('Error fetching user: $e\n$st');
      return Left(ServerFailure('Failed to fetch user'));
    }
  }


  BillingInfo? _parseBillingInfo(dynamic billingInfoData) {
    try {
      if (billingInfoData is Map<String, dynamic>) {
        return BillingInfo.fromJson(billingInfoData);
      } else if (billingInfoData is String) {
        final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(json.decode(billingInfoData));
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
    return 0;
  }

  List<String>? _parseSkills(dynamic skillsData) {
    if (skillsData == null) return null;

    if (skillsData is List<String>) {
      return skillsData;
    } else if (skillsData is List<dynamic>) {
      return skillsData.map((e) => e.toString()).toList();
    } else if (skillsData is String) {
      try {
        final List<dynamic> jsonList = json.decode(skillsData);
        return jsonList.map((e) => e.toString()).toList();
      } catch (e) {
        return [skillsData];
      }
    }
    return null;
  }

}