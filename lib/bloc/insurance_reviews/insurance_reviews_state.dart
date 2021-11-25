part of 'insurance_reviews_cubit.dart';

abstract class InsuranceReviewsState extends Equatable {
  const InsuranceReviewsState();
}

class InsuranceReviewsInitial extends InsuranceReviewsState {
  @override
  List<Object> get props => [];
}

class LoadInsuranceReviewsLoading extends InsuranceReviewsState {
  @override
  List<Object> get props => [];
}

class LoadInsuranceReviewsLoaded extends InsuranceReviewsState {
  final List<InsuranceReviewModel> insuranceReviewModels;

  LoadInsuranceReviewsLoaded(this.insuranceReviewModels);

  @override
  List<Object> get props => [insuranceReviewModels];
}

class LoadInsuranceReviewsFailure extends InsuranceReviewsState {
  @override
  List<Object> get props => [];
}
