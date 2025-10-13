import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/features/attachments/data/models/attachments_dm/attachments_dm.dart';
import 'package:taskly_admin/features/attachments/presentation/widgets/attachment_card_viewer_list_view.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';

class AttachmentsSection extends StatelessWidget {
  final List<AttachmentModel> attachmentEntity;

  const AttachmentsSection({
    super.key,
    required this.attachmentEntity,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (attachmentEntity.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${local.attachments}:",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),

        // Scrollable list of attachments
        SizedBox(
          height: 200.h,
          child: AttachmentCardViewerListView(
            attachmentEntity: attachmentEntity,
          ),
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
