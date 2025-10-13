import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/category_chip.dart';

class OrderHeaderSection extends StatelessWidget {
  final OrderEntity order;
  const OrderHeaderSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              Text("#${order.id.substring(0, 8)}", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CategoryChip(order.category ?? "No Category"),
            SizedBox(height: 4.h),
            Text(DateFormat('dd/MM/yyyy').format(order.createdAt), style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
