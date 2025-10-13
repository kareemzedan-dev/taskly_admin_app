import 'package:flutter/material.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

Color getStatusColor(String? status) {
  if (status == null) return Colors.grey;

  switch (status.toLowerCase()) {
    case 'active':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'suspended':
    case 'blocked':
      return Colors.red;
    case 'verified':
      return ColorsManager.primary;
    default:
      return Colors.grey;
  }
}
