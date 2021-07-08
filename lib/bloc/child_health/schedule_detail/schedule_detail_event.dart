import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ScheduleDetailsEvent extends Equatable {
  const ScheduleDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchScheduleDetails extends ScheduleDetailsEvent {
  final int id;
  const FetchScheduleDetails({@required this.id});
}