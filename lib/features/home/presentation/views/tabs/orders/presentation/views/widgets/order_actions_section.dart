import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import '../../manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import '../../manager/subscribe_to_offers_view_model/subscribe_to_offers_view_model.dart';
import '../../manager/subscribe_to_offers_view_model/subscribe_to_offers_states.dart';
import 'order_action_button.dart';
import 'offer_bottom_sheet_content.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import 'order_details_bottom_sheet.dart';

class OrderActionsSection extends StatelessWidget {
  final OrderEntity order;

  const OrderActionsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (order.status.name == OrderStatus.Cancelled.name) {
      return OrderActionButton(
        text: "Delete",
        icon: Icons.remove,
        color: Colors.red,
        onTap: () {

        },
      );
    }

    return Column(
      children: [
        BlocProvider(
          create:
              (context) =>
                  getIt<SubscribeToOffersViewModel>()..getOffers(order.id),
          child:
              BlocBuilder<SubscribeToOffersViewModel, SubscribeToOffersStates>(
                builder: (context, offerState) {
                  int count = 0;
                  if (offerState is SubscribeToOffersStatesSuccess) {
                    count = offerState.offers.length;
                  }
                  return OrderActionButton(
                    text: local.offers,
                    icon: Icons.local_offer_outlined,
                    color: ColorsManager.primary,
                    count: count,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),

                        builder: (context) {
                        return  OffersBottomSheetContent(
                                orderId: order.id,


                          );
                        },

                      );
                    },
                  );
                },
              ),
        ),

        const SizedBox(height: 10),

         OrderActionButton(
          text: local.viewDetails,
          icon: Icons.remove_red_eye_outlined,
          color: ColorsManager.primary,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder:
                  (context) => OrderDetailsBottomSheetContent(order: order),
            );
          },
        ),
      ],
    );
  }
}
