import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/insurance_review_model.dart';
import 'package:pocket_health/repository/insurance_reviews_repo.dart';

part 'insurance_reviews_state.dart';

class InsuranceReviewsCubit extends Cubit<InsuranceReviewsState> {
  final InsuranceReviewsRepo insuranceReviewsRepo;

  InsuranceReviewsCubit({@required this.insuranceReviewsRepo}) : super(InsuranceReviewsInitial());

  void loadInsuranceReviews() async {
    try {
      emit(LoadInsuranceReviewsLoading());
      final loadedReviews = await insuranceReviewsRepo.getReviews();
      emit(LoadInsuranceReviewsLoaded(loadedReviews));
    } catch (_) {
      emit(LoadInsuranceReviewsFailure());
      print("loadReviews | $_");
    }
  }
}
