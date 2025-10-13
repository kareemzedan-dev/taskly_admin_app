import 'package:injectable/injectable.dart';
import 'package:taskly_admin/features/home/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly_admin/features/home/data/models/offer_model/offer_model.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/offers/subscribe_to_offers_remote_data_source/subscribe_to_offers_remote_data_source.dart';

@Injectable(as: SubscribeToOffersRemoteDataSource)
class SubscribeToOffersRemoteDataSourceImpl
    extends SubscribeToOffersRemoteDataSource {
  final SupabaseService supabaseService;

  SubscribeToOffersRemoteDataSourceImpl(this.supabaseService);

  @override
  Stream<List<OfferEntity>> offerRealtimeRepository(String orderId) {
    return supabaseService
        .subscribeToTableByValue(
      table: "offers",
      column: "order_id",
      value: orderId,
    )
        .map((events) {
      return events
          .map((e) => OfferModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    });
  }


}
