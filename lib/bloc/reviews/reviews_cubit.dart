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
      final loadedReviews = await reviewsRepo.getReviews();
      emit(LoadReviewsLoaded(loadedReviews));
    } catch (_) {
	    emit(LoadReviewsFailure());
      print("loadReviews | $_");
    }
  }
}
