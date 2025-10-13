


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 

class CircularIconButton extends StatelessWidget {
    CircularIconButton({super.key,required this.image});
  String? image ;

  @override
  Widget build(BuildContext context) {
    return    Card(
          shadowColor: Colors.transparent,
        elevation: 10,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.w),
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
        ),
        child: Center(child: Image.asset(image!, height: 24.h, width: 24.w)),
      ),
    );
  }
}