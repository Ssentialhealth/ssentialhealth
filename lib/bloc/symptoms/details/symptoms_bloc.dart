import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/symptoms/details/symptoms_event.dart';
import 'package:pocket_health/bloc/symptoms/details/symptoms_state.dart';
import 'package:pocket_health/models/symptoms_detail_model.dart';
import 'package:pocket_health/repository/symptoms_repo.dart';


class SymptomDetailsBloc extends Bloc<SymptomDetailsEvent,SymptomDetailsState>{
  final SymptomDetailsRepo symptomDetailsRepo;
  SymptomDetailsBloc({@required this.symptomDetailsRepo}) : super(SymptomDetailsInitial());

  SymptomDetailsState get initialState => SymptomDetailsInitial();

  @override
  Stream<SymptomDetailsState> mapEventToState(
      SymptomDetailsEvent event)async*{
    if(event is FetchSymptomDetails){
      yield SymptomDetailsLoading();
      try{
        final SymptomDetail conditionDetails = await symptomDetailsRepo.getSymptomDetails(event.id);
        yield SymptomDetailsLoaded(conditionDetails);
      }catch(e){
        yield SymptomDetailsError();
        print(e.toString());
      }
    }
  }
}