import 'package:flutter/material.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/project_chat_view_body.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class ProjectChatView extends StatelessWidget {
  final String clientId;
  final String freelancerId;
  final double price;
  final String status;

  ProjectChatView({
    super.key,
    required this.clientId,
    required this.freelancerId,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar:   CustomAppBar(
        title: local.messages,
        image: Assets.assetsImagesUser12366536,
      ),
      body: ProjectChatViewBody(
        clientId: clientId,
        freelancerId: freelancerId,
        price: price,
        status: status,
        
      ),
      backgroundColor: Colors.white,
    );
  }
}
