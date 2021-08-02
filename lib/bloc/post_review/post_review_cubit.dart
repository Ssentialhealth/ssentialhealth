import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/repository/reviews_repo.dart';

part 'post_review_state.dart';

class PostReviewCubit extends Cubit<PostReviewState> {
  final ReviewsRepo reviewsRepo;

  PostReviewCubit(this.reviewsRepo) : super(PostReviewInitial());

  void loadInitial() {
    emit(PostReviewInitial());
  }

  void postReview({
    @required double rating,
    @required String comment,
    @required int profile,
    @required int user,
  }) async {
    try {
      emit(PostReviewsLoading());

      ReviewModel reviewModel = ReviewModel();
      reviewModel = ReviewModel(
        rating: rating,
        comment: comment,
        profile: profile,
        user: user,
      );
      final postedReviews = await reviewsRepo.addReview(reviewModel);
      emit(PostReviewDone(postedReviews));
    } catch (_) {
      print("postReviews | $_");
      emit(PostReviewsFailure());
    }
  }
}
