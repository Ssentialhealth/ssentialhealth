part of 'post_facility_review_cubit.dart';

abstract class PostFacilityReviewState extends Equatable {
  const PostFacilityReviewState();
}

class PostReviewInitial extends PostFacilityReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewDone extends PostFacilityReviewState {
  final FacilityReviewModel facilityReviewModel;

  PostReviewDone(this.facilityReviewModel);

  @override
  List<Object> get props => [facilityReviewModel];
}

class PostReviewsLoading extends PostFacilityReviewState {
  @override
  List<Object> get props => [];
}

class PostReviewsFailure extends PostFacilityReviewState {
  @override
  List<Object> get props => [];
}
