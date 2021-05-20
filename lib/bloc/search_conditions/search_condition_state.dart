import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/search_condition_model.dart';

abstract class SearchConditionState extends Equatable{
  const SearchConditionState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchConditionInitial extends SearchConditionState {}

class SearchConditionLoading extends SearchConditionState {}

class SearchConditionError extends SearchConditionState {}

class SearchConditionEmpty extends SearchConditionState {}

class SearchConditionLoaded extends SearchConditionState {
  final List<SearchCondition> searchCondition;
  @override
  List<SearchCondition> get props => [];

  SearchConditionLoaded(this.searchCondition) : assert(searchCondition != null);
}