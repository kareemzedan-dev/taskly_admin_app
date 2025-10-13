import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../data/models/attachments_dm/attachments_dm.dart';
import '../manager/download_attachments_view_model/download_attachments_view_model.dart';
import 'attachment_card_viewer.dart';

class AttachmentCardViewerListView extends StatelessWidget {
  final List<AttachmentModel> attachmentEntity;
 

  const AttachmentCardViewerListView({
    super.key,
    required this.attachmentEntity,
 
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DownloadAttachmentsViewModel>(),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: attachmentEntity.length,
          scrollDirection: Axis.vertical, // أو vertical
          itemBuilder: (context, index) {
            final attachment = attachmentEntity[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AttachmentItemViewer(
                attachmentName: attachment.name,
                attachmentPath: attachment.url,
                isFreelancer: true,
              ),
            );
          },
        ),
      ),
    );

  }
}
