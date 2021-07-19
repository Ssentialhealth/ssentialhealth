import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ImmunizationScheduleEvent extends Equatable {
  const ImmunizationScheduleEvent();

  @override
  List<Object> get props => [];
}

class CreateSchedule extends ImmunizationScheduleEvent {
  final String childName;
  final String childDob;

  CreateSchedule({@required this.childName, @required this.childDob});
}

class LoadInitial extends ImmunizationScheduleEvent {}
