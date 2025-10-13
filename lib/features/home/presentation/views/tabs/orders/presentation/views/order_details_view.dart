import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/views/widgets/order_details_view_body.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../domain/entities/order_entity/order_entity.dart';
import '../manager/update_order_status_view_model/update_order_status_view_model.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.order, required this.client, required this.freelancer});
  final OrderEntity order;
  final UserEntity client ;
  final UserEntity freelancer;
 
  @override
  Widget build(BuildContext context) {  
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      
      
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: local.orderDetails,

      ),
      body:   BlocProvider(
          create:  (context) =>  getIt<UpdateOrderStatusViewModel>(),
          child: OrderDetailsViewBody( order: order, client: client, freelancer: freelancer,)),
    );
  }
}
