import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_event.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_state.dart';
import 'package:pocket_health/models/Schedule_detail_model.dart';
import 'package:pocket_health/repository/schedule_detail_repo.dart';

class ScheduleDetailsBloc extends Bloc<ScheduleDetailsEvent, ScheduleDetailsState> {
  final ScheduleDetailRepo scheduleDetailRepo;

  ScheduleDetailsBloc({@required this.scheduleDetailRepo}) : super(ScheduleDetailsInitial());

  ScheduleDetailsState get initialState => ScheduleDetailsInitial();

  @override
  Stream<ScheduleDetailsState> mapEventToState(ScheduleDetailsEvent event) async* {
    if (event is FetchScheduleDetails) {
      yield ScheduleDetailsLoading();
      try {
        final List<ScheduleDetail> scheduleDetail = await scheduleDetailRepo.getScheduleDetail(event.id);
        yield ScheduleDetailsLoaded(scheduleDetail);
      } catch (e) {
        yield ScheduleDetailsError();
        print(e.toString());
      }
    }
  }
}
