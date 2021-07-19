import 'package:equatable/equatable.dart';

abstract class ScheduleDetailsEvent extends Equatable {
  const ScheduleDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchScheduleDetails extends ScheduleDetailsEvent {
  final int id;
  const FetchScheduleDetails(this.id);
}
