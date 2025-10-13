import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../../../messages/presentation/views/widgets/user_avatar.dart';
import '../../../../users/presentation/views/widgets/user_info_card_shimmer.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';

class OrderUserSection extends StatelessWidget {
  final String clientId;
  const OrderUserSection({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetUserInfoByIdViewModel>()..getUserInfoById(clientId),
      child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
        builder: (context, state) {
          if (state is GetUserInfoByIdLoading || state is GetUserInfoByIdError) {
            return const UserInfoCardShimmer();
          }
          if (state is GetUserInfoByIdSuccess) {
            final user = state.userEntity;
            return Row(
              children: [
                UserAvatar(imagePath: user.profileImage, radius: 20.r),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName ?? "", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(user.rating.toString(), style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
          return const UserInfoCardShimmer();
        },
      ),
    );
  }
}
