import 'package:flutter/material.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/features/reviews/presentation/widgets/reviews_page_body.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key, required this.userId, required this.userRole, required this.userName, required this.userImage , required this.userRating});
    final String userId ,    userRole ,  userName ,  userImage ,userRating ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  CustomAppBar(title: "Review", backgroundColor: Colors.white,   ),
      body: ReviewsPageBody( userId: userId, userRole: userRole, userName: userName, userImage: userImage, userRating: userRating,),
    );
  }
}