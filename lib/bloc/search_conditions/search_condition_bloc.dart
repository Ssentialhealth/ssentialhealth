import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_event.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_state.dart';
import 'package:pocket_health/models/search_condition_model.dart';
import 'package:pocket_health/repository/search_condition_repo.dart';

class SearchConditionBloc extends Bloc<SearchConditionEvent, SearchConditionState> {
  final SearchConditionRepo searchConditionRepo;

  SearchConditionBloc({@required this.searchConditionRepo}) : super(SearchConditionInitial());

  SearchConditionState get initialState => SearchConditionInitial();

  @override
  Stream<SearchConditionState> mapEventToState(SearchConditionEvent event) async* {
    if (event is FetchSearchCondition) {
      yield SearchConditionLoading();
      try {
        final List<SearchCondition> searchCondition = await searchConditionRepo.getConditions(event.condition);
        yield SearchConditionLoaded(searchCondition);
      } catch (e) {
        yield SearchConditionError();
        print(e.toString());
      }
    }
  }
}
