import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/repository/reviews_repo.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsCubit({@required this.reviewsRepo}) : super(ReviewsInitial());

  void loadReviews() async {
    try {
      emit(LoadReviewsLoading());
      emit(LoadReviewsLoaded());
    } catch (_) {
      print("loadReviews | $_");
    }
  }

  void postReview({
    @required String reviewerID,
    @required String datePosted,
    @required String reviewText,
    @required double rating,
    @required String practitionerID,
  }) async {
    try {
      emit(PostReviewsLoading());

      ReviewModel reviewModel = ReviewModel();
      reviewModel = ReviewModel(
        practitionerID: reviewerID,
        datePosted: datePosted,
        rating: rating,
        reviewText: reviewText,
        reviewerID: reviewerID,
      );
      final postedReviews = await reviewsRepo.addReview(reviewModel);
      emit(PostReviewsDone(postedReviews));
    } catch (_) {
      print("postReviews | $_");
      emit(PostReviewsFailure());
    }
  }
}
