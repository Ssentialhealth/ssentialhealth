import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/insurance_review_model.dart';
import 'package:pocket_health/repository/insurance_reviews_repo.dart';

part 'post_insurance_review_state.dart';

class PostInsuranceReviewCubit extends Cubit<PostInsuranceReviewState> {
  final InsuranceReviewsRepo insuranceReviewsRepo;

  PostInsuranceReviewCubit({this.insuranceReviewsRepo}) : super(PostReviewInitial());

  void loadInitial() {
    emit(PostReviewInitial());
  }

  void postReview({
    @required double rating,
    @required String comment,
    @required int insurance,
    @required int user,
  }) async {
    try {
      emit(PostReviewsLoading());

      InsuranceReviewModel reviewModel = InsuranceReviewModel();
      reviewModel = InsuranceReviewModel(
        comment: comment,
        user: user,
        rating: rating,
        healthInsuarance: insurance,
      );
      final postedReviews = await insuranceReviewsRepo.addReview(reviewModel);
      emit(PostReviewDone(postedReviews));
    } catch (_) {
      print("postReviews | $_");
      emit(PostReviewsFailure());
    }
  }
}
