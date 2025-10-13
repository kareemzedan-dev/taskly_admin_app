import 'package:flutter/material.dart';
import 'package:taskly_admin/core/components/custom_bottom_navigation_bar.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/dashboard/presentation/views/dashboard_tab_view.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/messages_tab_view.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/order_tab_view.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/payments/presentation/views/payment_tab_view.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/users_tab_view.dart';


class HomeView extends StatefulWidget {
    HomeView({super.key,   this.currentIndex= 0, this.initialIndex = 0});
  int currentIndex  ;
  int initialIndex  ;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = [
      DashboardTabView(),
      UsersTabView(initialIndex: widget.initialIndex),
      OrderTabView(),
      MessagesTabView(),
      PaymentTabView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: items[widget.currentIndex]),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}

