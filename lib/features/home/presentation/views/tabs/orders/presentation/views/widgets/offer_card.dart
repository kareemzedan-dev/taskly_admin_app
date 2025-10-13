// offer_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taskly_admin/core/helper/convert_to_days.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../reviews/presentation/pages/reviews_page.dart';
import '../../../../../../../domain/entities/offer_entity/offer_entity.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'user_info_section.dart';
import 'price_duration_section.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer, });

  final OfferEntity offer;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(color: ColorsManager.primary, width: 1.w),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BlocProvider(
                          create: (_) => getIt<GetUserInfoByIdViewModel>()..getUserInfoById(offer.freelancerId ?? ""),
                          child: BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
                            builder: (context, state) {
                              if (state is GetUserInfoByIdLoading) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                );
                              }

                              else if (state is GetUserInfoByIdSuccess) {
                                final user = state.userEntity;
                                if (user == null) return const SizedBox();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewsPage(
                                          userId: user.id,
                                          userImage: user.profileImage ?? "",
                                          userName: user.fullName ?? "",
                                          userRole: "freelancer",
                                          userRating: user.rating.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: UserInfoSection(
                                    name: user.fullName ?? "",
                                    email: user.email ?? "",
                                    rating: user.rating ?? 0,
                                    emailShow: true,
                                    photoSizeSelected: true,
                                    imagePath: user.profileImage ?? "",
                                  ),
                                );
                              } else if (state is GetUserInfoByIdError) {
                                return Text("Error: ${state.message}");
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ),




                      SizedBox(width: 8.w),

                      PriceDurationSection(
                        price: "${offer.offerAmount} SAR",
                        duration: offer.offerDeliveryTime.formatMinutes(),
                        status: offer.offerStatus,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    offer.offerDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.black,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
