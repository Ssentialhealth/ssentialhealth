import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/organs_search_model.dart';
import 'package:pocket_health/models/search_condition_model.dart';

abstract class SearchOrganState extends Equatable{
  const SearchOrganState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchOrganInitial extends SearchOrganState {}

class SearchOrganLoading extends SearchOrganState {}

class SearchOrganError extends SearchOrganState {}

class SearchOrganEmpty extends SearchOrganState {}

class SearchOrganLoaded extends SearchOrganState {
  final List<SearchOrgan> searchOrgan;
  @override
  List<SearchOrgan> get props => [];

  SearchOrganLoaded(this.searchOrgan) : assert(searchOrgan != null);
}