import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_offers_view_model/subscribe_to_offers_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_offers_view_model/subscribe_to_offers_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/offer_card.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/offer_header.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../../../core/di/di.dart';
import 'offer_card_shimmer.dart';
import 'offer_filter.dart';

class OffersBottomSheetContent extends StatefulWidget {
  const OffersBottomSheetContent({
    super.key,
    required this.orderId,

  });

  final String orderId;


  @override
  State<OffersBottomSheetContent> createState() => _OffersBottomSheetContentState();
}

class _OffersBottomSheetContentState extends State<OffersBottomSheetContent> {
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final filters = [local.price, local.delivery, local.rating];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      child: BlocProvider(
        create: (context) => getIt<SubscribeToOffersViewModel>()..getOffers(widget.orderId),
        child: BlocBuilder<SubscribeToOffersViewModel, SubscribeToOffersStates>(
          builder: (context, state) {
            if (state is SubscribeToOffersStatesLoading || state is SubscribeToOffersStatesError) {
              return OfferCardShimmer();
            }

            if (state is SubscribeToOffersStatesSuccess) {
              List offers = [...state.offers];

              // ✨ ترتيب العروض بناءً على الفلتر المختار
              if (selectedFilter != null) {
                if (selectedFilter == 'Price' || selectedFilter == local.price) {
                  offers.sort((a, b) => a.offerAmount.compareTo(b.offerAmount));
                } else if (selectedFilter == 'Delivery' || selectedFilter == local.delivery) {
                  offers.sort((a, b) => a.offerDeliveryTime.compareTo(b.offerDeliveryTime));
                } else if (selectedFilter == 'Rating' || selectedFilter == local.rating) {
                  offers.sort((a, b) => b.freelancerRating.compareTo(a.freelancerRating));
                }
              }


              return Column(
                children: [

                  OffersHeader(
                    title: local.offersReceived,
                    count: offers.length,
                    filters: filters,
                    selectedFilter: selectedFilter,
                    onFilterSelected: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: OfferCard(


                            offer: offers[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return OfferCardShimmer();
          },
        ),
      ),
    );
  }
}

