part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class ReviewsInitial extends ReviewsState {
  @override
  List<Object> get props => [];
}

class LoadReviewsLoaded extends ReviewsState {
  final List<ReviewModel> reviewModels;

  LoadReviewsLoaded(this.reviewModels);

  @override
  List<Object> get props => [reviewModels];
}

class LoadReviewsLoading extends ReviewsState {
  @override
  List<Object> get props => [];
}

class LoadReviewsFailure extends ReviewsState {
  @override
  List<Object> get props => [];
}
