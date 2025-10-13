import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../domain/entities/order_entity/order_entity.dart';
import '../widgets/order_category_details_view_body.dart';

class  OrderCategoryDetailsView extends StatelessWidget {
  const  OrderCategoryDetailsView({super.key,required this.order});
  final List<OrderEntity> order;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      appBar: CustomAppBar(
        title :"Orders Details"
      ),
          backgroundColor: Colors.white,
          body: OrderCategoryDetailsViewBody( order:  order),



    );
  }
}
