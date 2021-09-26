import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/facility_review_model.dart';
import 'package:pocket_health/repository/facility_reviews_repo.dart';

part 'facility_reviews_state.dart';

class FacilityReviewsCubit extends Cubit<FacilityReviewsState> {
  final FacilityReviewsRepo facilityReviewsRepo;

  FacilityReviewsCubit({@required this.facilityReviewsRepo}) : super(FacilityReviewsInitial());

  void loadFacilityReviews() async {
    try {
      emit(LoadFacilityReviewsLoading());
      final loadedReviews = await facilityReviewsRepo.getReviews();
      emit(LoadFacilityReviewsLoaded(loadedReviews));
    } catch (_) {
      emit(LoadFacilityReviewsFailure());
      print("loadReviews | $_");
    }
  }
}
