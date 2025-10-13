import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/home_view.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/get_order_by_id_view_model/get_order_by_id_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/activity_statistics.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/admin_actions.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/header_section.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/info_section.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/users/presentation/views/widgets/user_header_section.dart';
import 'package:taskly_admin/features/reviews/presentation/pages/reviews_page.dart';

class UsersBottomSheetDetails extends StatelessWidget {
  const UsersBottomSheetDetails({
    super.key,
    this.isFreelancer = false,
    required this.user,
  });

  final bool isFreelancer;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<GetOrdersByIdViewModel>()..getOrdersByUser(
                user.id,
                isFreelancer ? "freelancer" : "client",
              ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              SizedBox(height: 16.h),
              UserHeaderSection(user: user, isFreelancer: isFreelancer , onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsPage(
                      userId: user.id,
                      userImage: user.profileImage!,
                      userName: user.fullName!,
                      userRole: isFreelancer ? "freelancer" : "client",
                      userRating:  user.rating.toString(),
                      
                 
                     ),
                  ),
 
                );
              },),
              SizedBox(height: 26.h),
              InfoSection(user: user),
              SizedBox(height: 26.h),
              Divider(color: Colors.grey, thickness: 1.w),
              SizedBox(height: 16.h),
              ActivityStatistics(user: user, isFreelancer: isFreelancer),
              SizedBox(height: 26.h),
              Divider(color: Colors.grey, thickness: 1.w),
              SizedBox(height: 16.h),
              BlocListener<UpdateUserStatusViewModel, UpdateUserStatusStates>(
                listener: (context, state) {
                  if (state is UpdateUserStatusStatesSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(currentIndex: 1,initialIndex:isFreelancer ? 1 : 0 ,),
                      ),
                      (route) => false,
                    );
                  } else if (state is UpdateUserStatusStatesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update status")),
                    );
                  }
                },
                child: AdminActions(user: user, isFreelancer: isFreelancer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
