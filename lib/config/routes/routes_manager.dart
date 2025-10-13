import 'package:flutter/material.dart';
import 'package:taskly_admin/features/auth/presentation/views/login_view.dart';
import 'package:taskly_admin/features/auth/presentation/views/register_view.dart';
import 'package:taskly_admin/features/home/domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/home_view.dart';
import 'package:taskly_admin/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:taskly_admin/features/reviews/presentation/pages/reviews_page.dart';
import 'package:taskly_admin/features/splash/presentation/views/splash_view.dart';

import '../../features/home/domain/entities/order_entity/order_entity.dart';
import '../../features/home/domain/entities/user_entity/user_entity.dart';
import '../../features/home/presentation/views/tabs/dashboard/presentation/views/order_category_details_view.dart';
import '../../features/home/presentation/views/tabs/messages/presentation/views/chat_view.dart';
import '../../features/home/presentation/views/tabs/messages/presentation/views/project_chat_view.dart';
import '../../features/home/presentation/views/tabs/orders/presentation/views/order_details_view.dart';
import '../../features/home/presentation/views/tabs/payments/presentation/views/bank_account_details_view.dart';
import '../../features/home/presentation/views/tabs/payments/presentation/views/bank_account_view.dart';

class RoutesManager {
  static const String splash = "/";
  static const String onboarding = "onboarding";
  static const String login = "login";
  static const String register = "register";
  static const String homeView = "homeView";

  static const String chatView = "chatView";
  static const String bankAccountView = "bankAccountView";
  static const String bankAccountDetailsView = "bankAccountDetailsView";
  static const String projectChatView = "projectChatView";
  static const String orderDetailsView = "orderDetailsView";
  static const String reviewsView = "reviewsView";
  static const String orderCategoryDetailsView = "orderCategoryDetailsView";

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case homeView:
        return MaterialPageRoute(builder: (_) => HomeView());

      case chatView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              ChatView(
                userName: args['userName'],
                userImage: args['userImage'],
                currentUserId: args['currentUserId'],
                receiverId: args['receiverId'],
                currentUserRole: args['currentUserRole'],
                receiverUserRole: args['receiverUserRole'],
                userLastSeen: args['userLastSeen'],
                isOnline: args['isOnline'],
              ),
        );

      case bankAccountView:
        return MaterialPageRoute(builder: (_) => BankAccountView());

      case bankAccountDetailsView:
        final args = settings.arguments;
        if (args is BankAccountsEntity) {
          return MaterialPageRoute(
            builder: (_) => BankAccountDetailsView(bankAccountsEntity: args),
          );
        } else {
          return MaterialPageRoute(builder: (_) => BankAccountDetailsView());
        }

      case projectChatView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              ProjectChatView(
                clientId: args['clientId'],
                freelancerId: args['freelancerId'],
                price: args['price'],
                status: args['status'],
              ),
        );

      case orderDetailsView:
        final args = settings.arguments as Map<String, dynamic>;
        final order = args['order'] as OrderEntity;
        final client = args['client'] as UserEntity;
        final freelancer = args['freelancer'] as UserEntity;
        return MaterialPageRoute(
          builder: (_) =>
              OrderDetailsView(
                order: order,
                client: client,
                freelancer: freelancer,
              ),
        );

      case orderCategoryDetailsView:
        final args = settings.arguments as Map<String, dynamic>?;
        final orders = args?['orders'] as List<OrderEntity>?;
        if (orders != null && orders.isNotEmpty) {
          return MaterialPageRoute(
            builder: (_) => OrderCategoryDetailsView(order: orders),
          );
        }
        break;




      case reviewsView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              ReviewsPage(
                userId: args['userId'],
                userRole: args['userRole'],
                userName: args['userName'],
                userImage: args['userImage'],
                userRating: args['userRating'],
              ),
        );
    }


    return MaterialPageRoute(
      builder: (_) =>
      const Scaffold(
        body: Center(
          child: Text(
            'No route found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
