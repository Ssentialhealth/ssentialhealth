import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/Schedule_detail_model.dart';

abstract class ScheduleDetailsState extends Equatable {
  const ScheduleDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleDetailsInitial extends ScheduleDetailsState {}

class ScheduleDetailsLoading extends ScheduleDetailsState {}

class ScheduleDetailsError extends ScheduleDetailsState {}

class ScheduleDetailsEmpty extends ScheduleDetailsState {}

class ScheduleDetailsLoaded extends ScheduleDetailsState {
	final List<ScheduleDetail> scheduleDetails;

  @override
  List<ScheduleDetail> get props => scheduleDetails;

  ScheduleDetailsLoaded(this.scheduleDetails) : assert(scheduleDetails != null);
}
