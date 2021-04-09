import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailState.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsEvent.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/repository/conditionDetailRepo.dart';

class ConditionDetailsBloc extends Bloc<ConditionDetailsEvent,ConditionDetailsState>{
  final ConditionDetailsRepo conditionDetailsRepo;
  ConditionDetailsBloc({@required this.conditionDetailsRepo}) : super(ConditionDetailsInitial());

  ConditionDetailsState get initialState => ConditionDetailsInitial();

  @override
  Stream<ConditionDetailsState> mapEventToState(
      ConditionDetailsEvent event)async*{
    if(event is FetchDetails){
      yield ConditionDetailsLoading();
      try{
        final ConditionDetails conditionDetails = await conditionDetailsRepo.getConditionDetails(event.id);
        yield ConditionDetailsLoaded(conditionDetails);
      }catch(e){
        yield ConditionDetailsError();
        print(e.toString());
      }
    }
  }
}