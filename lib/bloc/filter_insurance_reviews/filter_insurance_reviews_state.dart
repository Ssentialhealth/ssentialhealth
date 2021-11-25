part of 'filter_insurance_reviews_cubit.dart';

abstract class FilterInsuranceReviewsState extends Equatable {
  const FilterInsuranceReviewsState();
}

class FilterReviewsInitial extends FilterInsuranceReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsLoading extends FilterInsuranceReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsFailure extends FilterInsuranceReviewsState {
  @override
  List<Object> get props => [];
}

class HighestRatedLoaded extends FilterInsuranceReviewsState {
  final List<InsuranceReviewModel> sortedByHighestRated;

  HighestRatedLoaded(this.sortedByHighestRated);

  @override
  List<Object> get props => [sortedByHighestRated];
}

class LowestRatedLoaded extends FilterInsuranceReviewsState {
  final List<InsuranceReviewModel> sortedByLowestRated;

  LowestRatedLoaded(this.sortedByLowestRated);

  @override
  List<Object> get props => [sortedByLowestRated];
}

class RecentlyRatedLoaded extends FilterInsuranceReviewsState {
  final List<InsuranceReviewModel> sortedByRecent;

  RecentlyRatedLoaded(this.sortedByRecent);

  @override
  List<Object> get props => [sortedByRecent];
}
