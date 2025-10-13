import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/user_avatar.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class ReviewItem extends StatelessWidget {
  final ReviewsEntity review;
  final VoidCallback onDelete;
  final String role;

  const ReviewItem({
    super.key,
    required this.review,
    required this.onDelete,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final rating = double.tryParse(review.rating) ?? 0.0;
    final isClient = review.role == 'client';
    final roleLabel = isClient ? local.client : local.freelancer;
    final roleColor = isClient ? Colors.blue : Colors.green;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      shadowColor: ColorsManager.primary.withOpacity(0.15),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Section - User Info and Actions
            BlocProvider(
              create: (_) => getIt<GetUserInfoByIdViewModel>()
                ..getUserInfoById(
                  role == 'freelancer' ? review.clientId : review.freelancerId,
                ),
              child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
                builder: (context, state) {
                  if (state is GetUserInfoByIdLoading) {
                    return _buildLoadingState();
                  }
                  if (state is GetUserInfoByIdError) {
                    return _buildErrorState(state.message);
                  }
                  if (state is GetUserInfoByIdSuccess) {
                    return _buildUserInfoSection(
                      context,
                      state.userEntity.fullName!,
                      state.userEntity.profileImage,
                      roleLabel,
                      roleColor,
                    );
                  }
                  return Container();
                },
              ),
            ),

            SizedBox(height: 12.h),

            /// Rating Section
            _buildRatingSection(rating),

            SizedBox(height: 10.h),

            /// Comment Section
            _buildCommentSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Row(
      children: [
        CircleAvatar(radius: 20.r, backgroundColor: Colors.grey.shade300),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 14.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Error loading user',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoSection(
    BuildContext context,
    String userName,
    String? profileImage,
    String roleLabel,
    Color roleColor,
  ) {
    return Row(
      children: [
        /// User Avatar
        UserAvatar(
          imagePath: profileImage,
          radius: 22.r,
        ),
        SizedBox(width: 12.w),

        /// User Name and Role
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: roleColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: roleColor, width: 0.8),
                ),
                child: Text(
                  roleLabel,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: roleColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        Spacer(),

        /// Date and Delete Button
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              review.createdAt,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(height: 6.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.red.shade100, width: 1),
              ),
              child: IconButton(
                iconSize: 18.sp,
                padding: EdgeInsets.all(6.w),
                constraints: BoxConstraints(
                  minWidth: 32.w,
                  minHeight: 32.h,
                ),
                icon: Icon(Icons.delete_rounded, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSection(double rating) {
    return Row(
      children: [
        /// Rating Label
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Colors.amber.shade300, width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_rounded,
                size: 14.sp,
                color: Colors.amber.shade700,
              ),
              SizedBox(width: 4.w),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber.shade800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),

        /// Stars
        Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Icon(
                index < rating.round() 
                    ? Icons.star_rounded 
                    : Icons.star_border_rounded,
                size: 18.sp,
                color: Colors.amber.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Text(
        review.comment,
        softWrap: true,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              height: 1.4,
              color: Colors.grey.shade800,
            ),
      ),
    );
  }
}