import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

extension UsersStatusLocalExtension on String {
  String toLocalizedStatus(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    switch (toLowerCase()) {
      case 'active':
        return local.active;
      case 'deactivate':
      case 'inactive':
        return local.inactive;
      default:
        return this;
    }
  }
}
