// MessagesTabViewBody.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/core/components/custom_search_text_field.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/core/utils/strings_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/message_card.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/project_message_card.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_conversations_view_model/get_conversations_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_conversations_view_model/get_conversations_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_orders_conversions_view_model/get_orders_conversions_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_orders_conversions_view_model/get_orders_conversions_states.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import 'package:taskly_admin/core/di/di.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class MessagesTabViewBody extends StatefulWidget {
  const MessagesTabViewBody({super.key});

  @override
  State<MessagesTabViewBody> createState() => _MessagesTabViewBodyState();
}

class _MessagesTabViewBodyState extends State<MessagesTabViewBody> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final adminId = SharedPrefHelper.getString(StringsManager.idKey);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GetConversationsViewModel>()
            ..getConversations(adminId!),
        ),
        BlocProvider(
          create: (_) => getIt<GetOrdersConversionsViewModel>()
            ..getOrdersConversions(),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSearchTextField(
                controller: _searchController,
                hintTexts: [local.searchByClientName,local.searchByName],
              ),

              const SizedBox(height: 16),
              TabBar(
                labelColor: ColorsManager.primary,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                indicatorColor: ColorsManager.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,
                tabs:   [
                  Tab(child: Text(local.clients)),
                  Tab(child: Text(local.freelancers)),
                  Tab(child: Text(local.projects)),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: TabBarView(
                  children: [
                    /// Clients Tab
                    BlocBuilder<GetConversationsViewModel,
                        GetConversationsStates>(
                      builder: (context, state) {

                        if (state is GetConversationsLoadingStates) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetConversationsErrorStates) {
                          return Center(
                              child: Text("Error: ${state.errorMessage}"));
                        } else if (state is GetConversationsSuccessStates) {
                          final filteredList = state.conversationsList.where((user) {
                            final name = user.fullName?.toLowerCase() ?? '';
                            return name.contains(_searchText);
                          }).toList();
                          if (filteredList.isEmpty) {
                            return   Center(child: Text(local.noConversationsFound));
                          }
                          if (state.conversationsList.isEmpty) {
                            return   Center(
                                child: Text( local.noConversationsFound));
                          }
                          return ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final user = filteredList[index];
                              if (user.role != "client") {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: MessagesCard(

                                  rating: user.rating!,

                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesManager.chatView,
                                      arguments: {
                                        "userName": user.fullName,
                                        "userImage": user.profileImage ??
                                            Assets.assetsImagesUsersAvatar,
                                        "currentUserId": adminId,
                                        "receiverId": user.id,
                                        "currentUserRole": "admin",
                                        "receiverUserRole": "client",
                                        "userLastSeen": user.lastSeen??DateTime.now(),
                                        "isOnline": user.isOnline ?? false,
                                      },
                                    );
                                  },
                                  name: user.fullName ?? "Unknown",
                                  message: (user.lastMessage == null || user.lastMessage!.trim().isEmpty)
                                      ? "مرفق"
                                      : user.lastMessage!,

                                  time: DateFormat("HH:mm a").format(user.lastMessageTime ?? DateTime.now()) ??"",
                                  status: user.clientStatus ?? "Active",
                                  statusColor: Colors.green,
                                  imagePath: user.profileImage,
                                  isFreelancer: false,
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    /// Freelancers Tab
                    BlocBuilder<GetConversationsViewModel,
                        GetConversationsStates>(
                      builder: (context, state) {
                        if (state is GetConversationsLoadingStates) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetConversationsErrorStates) {
                          return Center(
                              child: Text("Error: ${state.errorMessage}"));
                        } else if (state is GetConversationsSuccessStates) {
                          final filteredList = state.conversationsList.where((user) {
                            final name = user.fullName?.toLowerCase() ?? '';
                            return name.contains(_searchText);
                          }).toList();

                          if (filteredList.isEmpty) {
                            return   Center(
                                child: Text(local.noConversationsFound));
                          }
                          return ListView.builder(
                            itemCount: state.conversationsList.length,
                            itemBuilder: (context, index) {
                              final user = filteredList[index];
                              if (user.role != "freelancer") {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: MessagesCard(
                                  rating: user.rating!,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesManager.chatView,
                                      arguments: {
                                        "userName": user.fullName,
                                        "userImage": user.profileImage ??
                                            Assets.assetsImagesUsersAvatar,
                                        "currentUserId": adminId,
                                        "receiverId": user.id,
                                        "currentUserRole": "admin",
                                        "receiverUserRole": "freelancer",
                                        "userLastSeen": user.lastSeen!,
                                        "isOnline": user.isOnline ?? false,
                                      },
                                    );
                                  },
                                  name: user.fullName ?? "Unknown",
                                  message: (user.lastMessage == null || user.lastMessage!.trim().isEmpty)
                                      ? "مرفق"
                                      : user.lastMessage!,

                                  time: DateFormat("HH:mm a").format(user.lastMessageTime ?? DateTime.now()) ??"",
                                  status: user.freelancerStatus ?? "Active",
                                  statusColor: Colors.green,
                                  imagePath: user.profileImage,
                                  isFreelancer: true,

                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                  
                    BlocBuilder<GetOrdersConversionsViewModel,
                        GetOrdersConversionsStates>(
                      builder: (context, state) {

                        if (state is GetOrdersConversionsStatesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetOrdersConversionsStatesError) {
                          return Center(
                              child: Text("Error: ${state.message}"));
                        } else if (state is GetOrdersConversionsStatesSuccess) {
                          final filteredList = state.ordersConversionsList.where((order) {
                            final name = order.title.toLowerCase() ?? '';
                            return name.contains(_searchText);
                          }).toList();

                          if (filteredList.isEmpty) {
                            return const Center(
                                child: Text("No project conversations yet"));
                          }
                          return ListView.builder(
                            itemCount: state.ordersConversionsList.length,
                            itemBuilder: (context, index) {
                              final order = filteredList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ProjectCard(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesManager.projectChatView,
                                      arguments: {
                                         "clientId": order.clientId,
                                         "freelancerId": order.freelancerId,
                                         "price": order.budget,
                                         "status": order.status.name ?? "Unknown",
                                      },
                                    );
                                  },
                                  orderEntity: state.ordersConversionsList[index],
                                
                                  status: order.status.name ?? "Unknown",
                                  statusColor: order.status.name == "Completed"
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
