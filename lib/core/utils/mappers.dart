import 'package:taskly_admin/core/enums/user_status.dart';
import 'package:taskly_admin/core/enums/user_sort.dart';

UserStatus mapStringToStatus(String status) {
  switch (status) {
    case "active":
      return UserStatus.active;
    case "suspended":
      return UserStatus.suspended;
    case "pending":
      return UserStatus.pending;
    case "deactivate":
      return UserStatus.inactive;
    case "verified":
      return UserStatus.verified;
    case "unverified":
      return UserStatus.unverified;

    case "all":
    default:
      return UserStatus.all;
  }
}

UserSort mapStringToSort(String sort) {
  switch (sort) {
    case "highest_rating":
      return UserSort.highestRating;
    case "most_earnings":
      return UserSort.mostEarnings;
    case "most_completed":
      return UserSort.mostCompleted;
    case "newest":
      return UserSort.newest;
    case "oldest":
      return UserSort.oldest;
    default:
      return UserSort.newest;
  }
}
