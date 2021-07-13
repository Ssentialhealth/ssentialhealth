part of 'filter_reviews_cubit.dart';

abstract class FilterReviewsState extends Equatable {
  const FilterReviewsState();
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
  @override
  List<Object> get props => [];
}

class LowestRatedLoaded extends FilterReviewsState {
  @override
  List<Object> get props => [];
}

class RecentlyRatedLoaded extends FilterReviewsState {
  @override
  List<Object> get props => [];
}
