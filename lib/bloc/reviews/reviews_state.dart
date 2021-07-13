part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class ReviewsInitial extends ReviewsState {
  @override
  List<Object> get props => [];
}

class LoadReviewsLoaded extends ReviewsState {
  @override
  List<Object> get props => [];
}

class LoadReviewsLoading extends ReviewsState {
  @override
  List<Object> get props => [];
}

class LoadReviewsFailure extends ReviewsState {
  @override
  List<Object> get props => [];
}

class PostReviewsDone extends ReviewsState {
  final ReviewModel reviewModel;

  PostReviewsDone(this.reviewModel);

  @override
  List<Object> get props => [reviewModel];
}

class PostReviewsLoading extends ReviewsState {
  @override
  List<Object> get props => [];
}

class PostReviewsFailure extends ReviewsState {
  @override
  List<Object> get props => [];
}
