import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/agent_review_model.dart';
import 'package:pocket_health/repository/agent_reviews_repo.dart';

part 'agent_reviews_state.dart';

class AgentReviewsCubit extends Cubit<AgentReviewsState> {
  final AgentReviewsRepo agentReviewsRepo;

  AgentReviewsCubit({@required this.agentReviewsRepo}) : super(AgentReviewsInitial());

  void loadAgentReviews() async {
    try {
      emit(LoadAgentReviewsLoading());
      final loadedReviews = await agentReviewsRepo.getReviews();
      emit(LoadAgentReviewsLoaded(loadedReviews));
    } catch (_) {
      emit(LoadAgentReviewsFailure());
      print("loadReviews | $_");
    }
  }
}
