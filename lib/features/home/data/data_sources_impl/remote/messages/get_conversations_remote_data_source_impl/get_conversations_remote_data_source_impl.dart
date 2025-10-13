import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly_admin/core/errors/failures.dart';
import 'package:taskly_admin/core/services/supabase_service.dart';
import 'package:taskly_admin/features/home/data/data_sources/remote/messages_remote_data_sources/get_admin_conversations_remote_data_source/get_admin_conversations_remote_data_source.dart';
import 'package:taskly_admin/features/home/data/models/user_model/user_model.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';

@Injectable(as: GetAdminConversationsRemoteDataSource)
class GetConversationsRemoteDataSourceImpl
    extends GetAdminConversationsRemoteDataSource {
  final SupabaseService supabaseService;
  static const cacheKeyPrefix = 'conversations_';

  GetConversationsRemoteDataSourceImpl(this.supabaseService);

  // Helper to safely parse numeric values to double
  double parseNumeric(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    try {
      return double.parse(value.toString());
    } catch (_) {
      return 0.0;
    }
  }

  @override
  Future<Either<Failures, List<UserEntity>>> getConversations(
      String adminId,
      ) async {
    try {
      // Fetch messages involving the admin
      final response = await supabaseService.supabaseClient
          .from('messages')
          .select('sender_id, receiver_id, created_at')
          .or('sender_id.eq.$adminId,receiver_id.eq.$adminId')
          .order('created_at', ascending: false);

      final Map<String, dynamic> latestConversations = {};

      // Keep only latest message per user
      for (final msg in response) {
        final sender = msg['sender_id']?.toString();
        final receiver = msg['receiver_id']?.toString();
        if (sender == null || receiver == null) continue;

        final otherUserId = sender == adminId ? receiver : sender;
        if (!latestConversations.containsKey(otherUserId)) {
          latestConversations[otherUserId] = msg;
        }
      }

      final userIds = latestConversations.keys.toList();
      if (userIds.isEmpty) return const Right([]);

      // Fetch user details
      final usersResponse =
      await supabaseService.supabaseClient.from('users').select().inFilter('id', userIds);

      final List<UserModel> userModels = (usersResponse as List)
          .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();

      // Separate clients and freelancers
      final clientIds = userModels
          .where((u) => u.role.toLowerCase() == 'client')
          .map((u) => u.id)
          .toList();
      final freelancerIds = userModels
          .where((u) => u.role.toLowerCase() == 'freelancer')
          .map((u) => u.id)
          .toList();

      // Fetch client statuses
      final Map<String, String?> clientStatuses = {};
      if (clientIds.isNotEmpty) {
        final clientsResp = await supabaseService.supabaseClient
            .from('clients')
            .select('id, client_status')
            .inFilter('id', clientIds);
        for (final c in clientsResp) {
          final id = c['id']?.toString();
          if (id == null) continue;
          clientStatuses[id] = c['client_status']?.toString();
        }
      }

      // Fetch freelancer statuses
      final Map<String, String?> freelancerStatuses = {};
      if (freelancerIds.isNotEmpty) {
        final freelancersResp = await supabaseService.supabaseClient
            .from('freelancers')
            .select('id, freelancer_status')
            .inFilter('id', freelancerIds);
        for (final f in freelancersResp) {
          final id = f['id']?.toString();
          if (id == null) continue;
          freelancerStatuses[id] = f['freelancer_status']?.toString();
        }
      }

      final List<UserModel> enrichedModels = userModels.map((u) {
        final totalEarnings = parseNumeric(u.totalEarnings);
        final completedOrders = parseNumeric(u.completedOrders);
        final totalOrders = parseNumeric(u.totalOrders);
        final rating = parseNumeric(u.rating);

        print(
            "UserModel id=${u.id} totalEarnings=${totalEarnings} completedOrders=${completedOrders} totalOrders=${totalOrders} rating=${rating}");

        return UserModel(
          id: u.id,
          fullName: u.fullName,
          email: u.email,
          profileImage: u.profileImage,
          role: u.role,
          clientStatus: clientStatuses[u.id],
          freelancerStatus: freelancerStatuses[u.id],
          lastSeen: u.lastSeen,
          isOnline: u.isOnline,


          rating: rating,
        );
      }).toList();

      final enrichedEntities = enrichedModels.map((e) => e.toEntity()).toList();
      return Right(enrichedEntities);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
