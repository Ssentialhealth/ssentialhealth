import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_event.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_state.dart';
import 'package:pocket_health/bloc/search_organ/search_organ_event.dart';
import 'package:pocket_health/bloc/search_organ/search_organ_state.dart';
import 'package:pocket_health/models/organs_search_model.dart';
import 'package:pocket_health/models/search_condition_model.dart';
import 'package:pocket_health/repository/search_condition_repo.dart';
import 'package:pocket_health/repository/search_organs_repo.dart';

class SearchOrganBloc extends Bloc<SearchOrganEvent,SearchOrganState>{
  final SearchOrganRepo searchOrganRepo;
  SearchOrganBloc({@required this.searchOrganRepo}) : super(SearchOrganInitial());

  SearchOrganState get initialState => SearchOrganInitial();

  @override
  Stream<SearchOrganState> mapEventToState(
      SearchOrganEvent event) async*{
    if(event is FetchSearchOrgan){
      yield SearchOrganLoading();
      try{
        final List<SearchOrgan> searchOrgan = await searchOrganRepo.getOrgan(event.organ);
        yield SearchOrganLoaded(searchOrgan);
      }catch(e){
        yield SearchOrganError();
        print(e.toString());
      }
    }

  }
}