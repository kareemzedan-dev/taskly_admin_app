import 'package:flutter_bloc/flutter_bloc.dart';
 
class FilterViewModel extends Cubit<FilterState> {
  FilterViewModel(String allLabel) : super(FilterState.initial(allLabel));

  void selectStatus(String status) {
    emit(state.copyWith(selectedStatus: status));
  }

  void selectSort(String sort) {
    emit(state.copyWith(selectedSort: sort));
  }

  void clearFilters(String allLabel) {
    emit(FilterState.initial(allLabel));
  }
}


class FilterState {
  final String? selectedStatus;
  final String? selectedSort;

  const FilterState({
    this.selectedStatus,
    this.selectedSort,
  });

  FilterState copyWith({
    String? selectedStatus,
    String? selectedSort,
  }) {
    return FilterState(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedSort: selectedSort ?? this.selectedSort,
    );
  }

  // 👇 default يكون All بدل null
  factory FilterState.initial(String allLabel) {
    return FilterState(
      selectedStatus: allLabel, // default selected
      selectedSort: null,
    );
  }
}

