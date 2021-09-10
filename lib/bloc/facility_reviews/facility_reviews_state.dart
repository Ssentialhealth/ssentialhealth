part of 'facility_reviews_cubit.dart';

abstract class FacilityReviewsState extends Equatable {
  const FacilityReviewsState();
}

class FacilityReviewsInitial extends FacilityReviewsState {
  @override
  List<Object> get props => [];
}

class LoadFacilityReviewsLoading extends FacilityReviewsState {
  @override
  List<Object> get props => [];
}

class LoadFacilityReviewsLoaded extends FacilityReviewsState {
  final List<FacilityReviewModel> facilityReviewModels;

  LoadFacilityReviewsLoaded(this.facilityReviewModels);

  @override
  List<Object> get props => [facilityReviewModels];
}

class LoadFacilityReviewsFailure extends FacilityReviewsState {
  @override
  List<Object> get props => [];
}
