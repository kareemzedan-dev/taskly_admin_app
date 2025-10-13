import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import 'attachment_section.dart';
import 'description_section.dart';
import 'job_header.dart';


class OrderDetailsBottomSheetContent extends StatelessWidget {
  const OrderDetailsBottomSheetContent({super.key,required this.order});
  final OrderEntity order;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobHeader(
                title: order.title,
                category: order.category!,
                date:  DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt),
              ),

              SizedBox(height: 16.h),

              DescriptionSection(description: order.description!),
              SizedBox(height: 16.h),
              AttachmentsSection(  attachmentEntity: order.attachments,),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
