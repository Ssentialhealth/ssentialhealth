import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_event.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_state.dart';
import 'package:pocket_health/models/immunization_schedule_model.dart';
import 'package:pocket_health/repository/immunization_schedule_repo.dart';

class ImmunizationScheduleBloc extends Bloc<ImmunizationScheduleEvent,ImmunizationScheduleState>{
  final ImmunizationScheduleRepo immunizationScheduleRepo;
  ImmunizationScheduleBloc({@required this.immunizationScheduleRepo}) : super(ImmunizationScheduleInitial());

  ImmunizationScheduleState get initialState => ImmunizationScheduleInitial();


  @override
  Stream<ImmunizationScheduleState> mapEventToState(
      ImmunizationScheduleEvent event,
      ) async* {
    if (event is CreateSchedule) {
      yield ImmunizationScheduleLoading();
      try {
        final ImmunizationScheduleModel immunizationScheduleModel = await immunizationScheduleRepo.createSchedule(
          event.childName,
          event.childDob,
        );

        yield ImmunizationScheduleLoaded(immunizationScheduleModel);

      } catch (e) {
        yield ImmunizationScheduleError(e.toString());
        print("Name:"+e.toString());
      }
    }
  }


}





