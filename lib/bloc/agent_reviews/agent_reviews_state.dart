part of 'agent_reviews_cubit.dart';

abstract class AgentReviewsState extends Equatable {
  const AgentReviewsState();
}

class AgentReviewsInitial extends AgentReviewsState {
  @override
  List<Object> get props => [];
}

class LoadAgentReviewsLoading extends AgentReviewsState {
  @override
  List<Object> get props => [];
}

class LoadAgentReviewsLoaded extends AgentReviewsState {
  final List<AgentReviewModel> agentReviewModels;

  LoadAgentReviewsLoaded(this.agentReviewModels);

  @override
  List<Object> get props => [agentReviewModels];
}

class LoadAgentReviewsFailure extends AgentReviewsState {
  @override
  List<Object> get props => [];
}
