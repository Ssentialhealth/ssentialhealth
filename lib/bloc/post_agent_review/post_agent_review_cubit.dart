import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/agent_review_model.dart';
import 'package:pocket_health/repository/agent_reviews_repo.dart';

part 'post_agent_review_state.dart';

class PostAgentReviewCubit extends Cubit<PostAgentReviewState> {
  final AgentReviewsRepo agentReviewsRepo;

  PostAgentReviewCubit({this.agentReviewsRepo}) : super(PostReviewInitial());

  void loadInitial() {
    emit(PostReviewInitial());
  }

  void postReview({
    @required double rating,
    @required String comment,
    @required int agent,
    @required int user,
  }) async {
    try {
      emit(PostReviewsLoading());

      AgentReviewModel reviewModel = AgentReviewModel();
      reviewModel = AgentReviewModel(
        comment: comment,
        user: user,
        rating: rating,
        agent: agent,
      );
      final postedReviews = await agentReviewsRepo.addReview(reviewModel);
      emit(PostReviewDone(postedReviews));
    } catch (_) {
      print("postReviews | $_");
      emit(PostReviewsFailure());
    }
  }
}
