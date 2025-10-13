import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDescription extends StatelessWidget {
  final String description;

  const OrderDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
