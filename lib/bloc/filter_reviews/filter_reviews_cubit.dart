import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_reviews_state.dart';

class FilterReviewsCubit extends Cubit<FilterReviewsState> {
  FilterReviewsCubit() : super(RecentlyRatedLoaded());

  //recent
  void loadRecentlyRated() async {
    try {
      emit(FilterReviewsLoading());

      /////fetch reviews
      emit(RecentlyRatedLoaded());
    } catch (_) {
      emit(FilterReviewsFailure());
      print("loadRecentlyRated failed | $_");
    }
  }

  //highest
  void loadHighestRated() async {
    try {
      emit(FilterReviewsLoading());

      /////fetch reviews
      emit(HighestRatedLoaded());
    } catch (_) {
      emit(FilterReviewsFailure());
      print("loadHighestRated failed | $_");
    }
  }

  //lowest
  void loadLowestRated() async {
    try {
      emit(FilterReviewsLoading());

      /////fetch reviews
      emit(LowestRatedLoaded());
    } catch (_) {
      emit(FilterReviewsFailure());
      print("loadLowestRated failed | $_");
    }
  }
}
