import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/repository/child_condition_detail_repo.dart';

import 'child_condition_detail_event.dart';
import 'child_condition_detail_state.dart';

class ChildConditionDetailsBloc extends Bloc<ChildConditionDetailsEvent,ChildConditionDetailsState>{
  final ChildConditionDetailRepo childConditionDetailRepo;
  ChildConditionDetailsBloc({@required this.childConditionDetailRepo}) : super(ChildConditionDetailsInitial());

  ChildConditionDetailsState get initialState => ChildConditionDetailsInitial();

  @override
  Stream<ChildConditionDetailsState> mapEventToState(
      ChildConditionDetailsEvent event)async*{
    if(event is FetchChildConditionDetails){
      yield ChildConditionDetailsLoading();
      try{
        final ChildConditionsDetailModel childConditionsDetailModel = await childConditionDetailRepo.getConditionDetails(event.id);
        yield ChildConditionDetailsLoaded(childConditionsDetailModel);
      }catch(e){
        yield ChildConditionDetailsError();
        print(e.toString());
      }
    }
  }
}