import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly_admin/core/enums/user_sort.dart';
import 'package:taskly_admin/core/enums/user_status.dart';
import '../../../../../../../domain/entities/user_entity/user_entity.dart';
import '../../../../../../../domain/use_cases/get_all_users_use_case/get_all_users_use_case.dart';
import 'get_all_users_states.dart';

@injectable
class GetAllUsersViewModel extends Cubit<GetAllUsersStates> {
  GetAllUsersViewModel(this.getAllUsersUseCase) : super(GetAllUsersInitial());

  final GetAllUsersUseCase getAllUsersUseCase;

  // ---- Filters ----
  UserStatus selectedStatus = UserStatus.all;
  UserSort? selectedSort;

  // ---- Search ----
  String searchQuery = '';

  // all users (raw data from backend)
  List<UserEntity> allUsers = [];

  // ---- Get all users ----
  Future<void> getAllUsers() async {
    try {
      emit(GetAllUsersLoadingState());
      final result = await getAllUsersUseCase.call();
      result.fold(
        (failure) => emit(GetAllUsersErrorState(failure.message)),
        (users) {
          allUsers = users;
          _applyFilters();
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(GetAllUsersErrorState(e.toString()));
      }
    }
  }

  // ---- Update filters ----
  void updateStatus(UserStatus status) {
    selectedStatus = status;
    _applyFilters();
  }

  void updateSort(UserSort? sort) {
    selectedSort = sort;
    _applyFilters();
  }

  void clearFilters() {
    selectedStatus = UserStatus.all;
    selectedSort = null;
    searchQuery = '';
    _applyFilters();
  }

  // ---- Search ----
  void searchUsers(String query) {
    searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    List<UserEntity> filtered = List.from(allUsers);

    // filter by status
    if (selectedStatus != UserStatus.all) {
      filtered = filtered.where((u) {
        final userStatus =
            u.role == "client" ? u.clientStatus : u.freelancerStatus;
        return userStatus?.toLowerCase() ==
            selectedStatus.name.toLowerCase();
      }).toList();
    }

    // filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((u) {
        return (u.fullName?.toLowerCase().contains(searchQuery) ?? false) ||
               (u.email.toLowerCase().contains(searchQuery) ?? false);
      }).toList();
    }

    // sort
    if (selectedSort != null) {
      switch (selectedSort!) {
        case UserSort.highestRating:
          filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
          break;
        case UserSort.mostEarnings:
          filtered.sort((a, b) =>
              (b.freelancerBalance ?? 0).compareTo(a.freelancerBalance ?? 0));
          break;
        case UserSort.mostCompleted:
          filtered.sort((a, b) =>
              (b.jobsCount ?? 0).compareTo(a.jobsCount ?? 0));
          break;
        case UserSort.newest:
          filtered.sort((a, b) =>
              (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
          break;
        case UserSort.oldest:
          filtered.sort((a, b) =>
              (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
          break;
      }
      print("Filtered Users (${filtered.length}):");
      for (var u in filtered) {
        print({
          'id': u.id,
          'name': u.fullName,
          'email': u.email,
          'role': u.role,
          'clientStatus': u.clientStatus,
          'freelancerStatus': u.freelancerStatus,
          'freelancerBalance': u.freelancerBalance,
          'rating': u.rating,
          'jobsCount': u.jobsCount,
          'createdAt': u.createdAt,
        });
      }
    }

    final clients = filtered.where((u) => u.role == 'client').toList();
    final freelancers = filtered.where((u) => u.role == 'freelancer').toList();

    emit(GetAllUsersSuccessState(
      users: filtered,
      clientsCount: clients.length,
      freelancersCount: freelancers.length,
    ));
  }
}
