part of 'post_review_cubit.dart';

abstract class PostReviewState extends Equatable {
  const PostReviewState();
}

class PostReviewInitial extends PostReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewDone extends PostReviewState {
  final ReviewModel reviewModel;

  PostReviewDone(this.reviewModel);

  @override
  List<Object> get props => [reviewModel];
}

class PostReviewsLoading extends PostReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewsFailure extends PostReviewState {
  @override
  List<Object> get props => [];
}
