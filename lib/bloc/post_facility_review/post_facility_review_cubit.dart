import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/facility_review_model.dart';
import 'package:pocket_health/repository/facility_reviews_repo.dart';

part 'post_facility_review_state.dart';

class PostFacilityReviewCubit extends Cubit<PostFacilityReviewState> {
  final FacilityReviewsRepo facilityReviewsRepo;

  PostFacilityReviewCubit({this.facilityReviewsRepo}) : super(PostReviewInitial());

  void loadInitial() {
    emit(PostReviewInitial());
  }

  void postReview({
    @required double rating,
    @required String comments,
    @required int facility,
    @required double affordability,
    @required double customerCare,
    @required double serviceProductsAvailability,
    @required double timely,
    @required int user,
  }) async {
    try {
      emit(PostReviewsLoading());

      FacilityReviewModel reviewModel = FacilityReviewModel();
      reviewModel = FacilityReviewModel(
        comments: comments,
        affordability: affordability,
        customerCare: customerCare,
        serviceProductsAvailability: serviceProductsAvailability,
        timely: timely,
        facility: facility,
        user: user,
        rating: rating,
      );
      final postedReviews = await facilityReviewsRepo.addReview(reviewModel);
      emit(PostReviewDone(postedReviews));
    } catch (_) {
      print("postReviews | $_");
      emit(PostReviewsFailure());
    }
  }
}
