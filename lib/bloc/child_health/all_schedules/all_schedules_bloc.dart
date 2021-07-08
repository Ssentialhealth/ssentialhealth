import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_state.dart';
import 'package:pocket_health/models/all_schedules_model.dart';
import 'package:pocket_health/repository/all_schedules_repo.dart';

import 'all_schedules_event.dart';
import 'all_schedules_state.dart';


class AllSchedulesBloc extends Bloc<AllSchedulesEvent,AllSchedulesState>{
  final AllScheduleRepo allSchedulesRepo;
  AllSchedulesBloc({@required this.allSchedulesRepo}) : super(AllSchedulesInitial()){
    add(FetchAllSchedules());
  }

  AllSchedulesState get initialState => AllSchedulesInitial();

  @override
  Stream<AllSchedulesState> mapEventToState(
      AllSchedulesEvent event
      ) async*{
    if(event is FetchAllSchedules){
      yield AllSchedulesLoading();
      try{
        final List<AllScheduleModel> allScheduleModel = await allSchedulesRepo.getAllSchedules();
        yield AllSchedulesLoaded(allScheduleModel);
      }catch(e){
        yield AllSchedulesError();
        print(e.toString());
      }
    }
  }

}