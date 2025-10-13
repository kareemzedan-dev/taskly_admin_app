import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

import '../../../../../../domain/entities/order_entity/order_entity.dart';

class OrderCategoryDetailsViewBody extends StatelessWidget {
  const OrderCategoryDetailsViewBody({super.key, required this.order});

  final List<OrderEntity> order;

  Map<String, dynamic> _calculateStats(List<OrderEntity> orders) {
    final totalOrders = orders.length;

    final pendingOrders = orders.where((order) => order.status.name.toLowerCase() == 'pending').length;
    final completedOrders = orders.where((order) => order.status.name.toLowerCase() == 'completed').length;
    final cancelledOrders = orders.where((order) => order.status.name.toLowerCase() == 'cancelled').length;
    final acceptedOrders = orders.where((order) => order.status.name.toLowerCase() == 'accepted').length;

    final totalRevenue = orders.where((order) => order.status.name.toLowerCase() == 'completed').fold<double>(0, (sum, order) => sum + (order.budget ?? 0));

    return {
      'total': totalOrders,
      'Pending': pendingOrders,
      'Accepted': acceptedOrders,
      'Completed': completedOrders,
      'Cancelled': cancelledOrders,
      'revenue': totalRevenue,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;

      case 'Completed':
        return Colors.green;
        case 'Accepted':
          return Colors.blue;
      case 'Cancelled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats(order);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainStatsCard(context, stats),
            SizedBox(height: 24.h),

            _buildDetailedStats(context, stats),
            SizedBox(height: 24.h),

            _buildRecentOrders(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainStatsCard(BuildContext context, Map<String, dynamic> stats) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.primary.withOpacity(0.9),
            ColorsManager.primary.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Total Orders",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            stats['total'].toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMiniStat(
                context,
                "Completed",
                stats['Completed'].toString(),
                Colors.green,
              ),
              _buildMiniStat(
                context,
              "Accepted" ,
                stats['Accepted'].toString(),

              Colors.blue,
              ),
              _buildMiniStat(
                context,
                "Pending",
                stats['Pending'].toString(),
                Colors.orange,
              ),
              _buildMiniStat(
                context,
                "Cancelled",
                stats['Cancelled'].toString(),
                Colors.red,
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(BuildContext context, String title, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedStats(BuildContext context, Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Statistics",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 16.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard(
              context,
              "Total Revenue",
              "\$${stats['revenue'].toStringAsFixed(2)}",
              Icons.attach_money_rounded,
              Colors.green,
            ),
            _buildStatCard(
              context,
              "Pending Orders",
              stats['pending'].toString(),
              Icons.pending_actions_rounded,
              Colors.orange,
            ),
            _buildStatCard(
    context,
              "Accepted Orders",
              stats['accepted'].toString(),
              Icons.check_circle_rounded,
              Colors.blue,
                ),
            _buildStatCard(
              context,
              "Completed",
              stats['completed'].toString(),
              Icons.check_circle_rounded,
              Colors.blue,
            ),
            _buildStatCard(
              context,
              "Cancelled",
              stats['cancelled'].toString(),
              Icons.cancel_rounded,
              Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20.w,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders(BuildContext context) {
    final recentOrders = order.take(5).toList(); // آخر 5 طلبات

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Orders",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            Text(
              "View All",
              style: TextStyle(
                color: ColorsManager.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...recentOrders.map((order) => _buildOrderItem(context, order)).toList(),
        if (recentOrders.isEmpty)
          Container(
            padding: EdgeInsets.all(32.w),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  size: 48.w,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  "No orders found",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildOrderItem(BuildContext context, OrderEntity order) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          // أيقونة الحالة
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status.name ?? 'pending').withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(order.status.name ?? 'pending'),
              color: _getStatusColor(order.status.name ?? 'pending'),
              size: 16.w,
            ),
          ),
          SizedBox(width: 12.w),

          // تفاصيل الطلب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order #${order.id.substring(0, 8)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "\$${order.budget?.toStringAsFixed(2) ?? '0.00'}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // تاريخ الطلب
          Text(
            _formatDate(order.createdAt),
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending_rounded;
      case 'completed':

        return Icons.check_circle_rounded;
        case 'accepted':
          return Icons.check_circle_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.receipt_rounded;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}