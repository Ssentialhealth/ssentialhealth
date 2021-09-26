part of 'filter_facility_reviews_cubit.dart';

abstract class FilterFacilityReviewsState extends Equatable {
  const FilterFacilityReviewsState();
}

class FilterReviewsInitial extends FilterFacilityReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsLoading extends FilterFacilityReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsFailure extends FilterFacilityReviewsState {
  @override
  List<Object> get props => [];
}

class HighestRatedLoaded extends FilterFacilityReviewsState {
  final List<FacilityReviewModel> sortedByHighestRated;

  HighestRatedLoaded(this.sortedByHighestRated);

  @override
  List<Object> get props => [sortedByHighestRated];
}

class LowestRatedLoaded extends FilterFacilityReviewsState {
  final List<FacilityReviewModel> sortedByLowestRated;

  LowestRatedLoaded(this.sortedByLowestRated);

  @override
  List<Object> get props => [sortedByLowestRated];
}

class RecentlyRatedLoaded extends FilterFacilityReviewsState {
  final List<FacilityReviewModel> sortedByRecent;

  RecentlyRatedLoaded(this.sortedByRecent);

  @override
  List<Object> get props => [sortedByRecent];
}
