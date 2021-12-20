part of 'post_insurance_review_cubit.dart';

abstract class PostInsuranceReviewState extends Equatable {
  const PostInsuranceReviewState();
}

class PostReviewInitial extends PostInsuranceReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewDone extends PostInsuranceReviewState {
  final InsuranceReviewModel insuranceReviewModel;
  PostReviewDone(this.insuranceReviewModel);

  @override
  List<Object> get props => [insuranceReviewModel];
}

class PostReviewsLoading extends PostInsuranceReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewsFailure extends PostInsuranceReviewState {
  @override
  List<Object> get props => [];
}
