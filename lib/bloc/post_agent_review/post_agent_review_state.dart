part of 'post_agent_review_cubit.dart';

abstract class PostAgentReviewState extends Equatable {
  const PostAgentReviewState();
}

class PostReviewInitial extends PostAgentReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewDone extends PostAgentReviewState {
  final AgentReviewModel agentReviewModel;
  PostReviewDone(this.agentReviewModel);

  @override
  List<Object> get props => [agentReviewModel];
}

class PostReviewsLoading extends PostAgentReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewsFailure extends PostAgentReviewState {
  @override
  List<Object> get props => [];
}
