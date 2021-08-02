import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/review_model.dart';

part 'filter_reviews_state.dart';

class FilterReviewsCubit extends Cubit<FilterReviewsState> {
	FilterReviewsCubit() : super(FilterReviewsInitial());

  //recent
	void loadRecentlyRated({List<ReviewModel> toSort}) async {
    try {
      emit(FilterReviewsLoading());

      emit(RecentlyRatedLoaded(toSort));
    } catch (_) {
      emit(FilterReviewsFailure());
      print("loadRecentlyRated failed | $_");
    }
  }

  //highest
	void loadHighestRated({List<ReviewModel> toSort}) async {
    try {
      emit(FilterReviewsLoading());

      /////fetch reviews
      toSort.sort((a, b) => b.rating.toDouble().compareTo(a.rating.toDouble()));

      emit(HighestRatedLoaded(toSort));
    } catch (_) {
      emit(FilterReviewsFailure());
      print("loadHighestRated failed | $_");
    }
  }

  //lowest
	void loadLowestRated({List<ReviewModel> toSort}) async {
    try {
      emit(FilterReviewsLoading());

      //
      toSort.sort((a, b) => a.rating.toDouble().compareTo(b.rating.toDouble()));

      emit(LowestRatedLoaded(toSort));
    } catch (_) {
      emit(FilterReviewsFailure());
      print("loadLowestRated failed | $_");
    }
  }
}
