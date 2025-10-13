import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHeader extends StatelessWidget {
  final String orderName;
  final String orderId;

  const OrderHeader({
    super.key,
    required this.orderName,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اسم الطلب
          Text(
            orderName,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),

          SizedBox(height: 4.h),

          // رقم الطلب
          Text(
            "#${orderId.substring(0, orderId.length >= 8 ? 8 : orderId.length)}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
