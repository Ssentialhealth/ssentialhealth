part of 'filter_reviews_cubit.dart';

abstract class FilterReviewsState extends Equatable {
  const FilterReviewsState();
}

class FilterReviewsInitial extends FilterReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsLoading extends FilterReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsFailure extends FilterReviewsState {
  @override
  List<Object> get props => [];
}

class HighestRatedLoaded extends FilterReviewsState {
  final List<ReviewModel> sortedByHighestRated;

  HighestRatedLoaded(this.sortedByHighestRated);

  @override
  List<Object> get props => [sortedByHighestRated];
}

class LowestRatedLoaded extends FilterReviewsState {
  final List<ReviewModel> sortedByLowestRated;

  LowestRatedLoaded(this.sortedByLowestRated);

  @override
  List<Object> get props => [sortedByLowestRated];
}

class RecentlyRatedLoaded extends FilterReviewsState {
  final List<ReviewModel> sortedByRecent;

  RecentlyRatedLoaded(this.sortedByRecent);

  @override
  List<Object> get props => [sortedByRecent];
}
