import 'package:taskly_admin/core/enums/user_status.dart';
import 'package:taskly_admin/core/enums/user_sort.dart';

UserStatus mapStringToStatus(String status) {
  switch (status.toLowerCase()) {
    case "active":
      return UserStatus.active;
    case "suspended":
      return UserStatus.suspended;
    case "pending":
      return UserStatus.pending;
    case "inactive":
      return UserStatus.inactive;
    default:
      return UserStatus.all;
  }
}

UserSort mapStringToSort(String sort) {
  switch (sort.toLowerCase()) {
    case "highest rating":
      return UserSort.highestRating;
    case "most earnings":
      return UserSort.mostEarnings;
    case "most completed":
      return UserSort.mostCompleted;
    case "newest":
      return UserSort.newest;
    case "oldest":
      return UserSort.oldest;
    default:
      return UserSort.newest; // fallback
  }
}
