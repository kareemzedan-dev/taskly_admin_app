import 'package:flutter/material.dart';
import 'package:taskly_admin/core/components/custom_app_bar.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/views/widgets/messages_tab_view_body.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class MessagesTabView extends StatelessWidget {
  const MessagesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      body: MessagesTabViewBody(),
      backgroundColor: Colors.white,
      appBar:   CustomAppBar(title: local.messages,image: Assets.assetsImagesChat6431892,),
    );
  }
}
