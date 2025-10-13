import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPriceInfo extends StatelessWidget {
  final double price;

  const OrderPriceInfo({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.attach_money, size: 20.sp, color: Colors.green),
        SizedBox(width: 6.w),
        Text(
          "\$$price",
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
