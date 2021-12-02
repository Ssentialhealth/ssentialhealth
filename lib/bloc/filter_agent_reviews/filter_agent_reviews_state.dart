part of 'filter_agent_reviews_cubit.dart';

abstract class FilterAgentReviewsState extends Equatable {
  const FilterAgentReviewsState();
}

class FilterReviewsInitial extends FilterAgentReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsLoading extends FilterAgentReviewsState {
  @override
  List<Object> get props => [];
}

class FilterReviewsFailure extends FilterAgentReviewsState {
  @override
  List<Object> get props => [];
}

class HighestRatedLoaded extends FilterAgentReviewsState {
  final List<AgentReviewModel> sortedByHighestRated;

  HighestRatedLoaded(this.sortedByHighestRated);

  @override
  List<Object> get props => [sortedByHighestRated];
}

class LowestRatedLoaded extends FilterAgentReviewsState {
  final List<AgentReviewModel> sortedByLowestRated;

  LowestRatedLoaded(this.sortedByLowestRated);

  @override
  List<Object> get props => [sortedByLowestRated];
}

class RecentlyRatedLoaded extends FilterAgentReviewsState {
  final List<AgentReviewModel> sortedByRecent;

  RecentlyRatedLoaded(this.sortedByRecent);

  @override
  List<Object> get props => [sortedByRecent];
}
