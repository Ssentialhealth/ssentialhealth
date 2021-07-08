import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/immunization_schedule_model.dart';

abstract class ImmunizationScheduleState extends Equatable{
  const ImmunizationScheduleState();

  @override
  List<Object> get props => [];
}

class ImmunizationScheduleInitial extends ImmunizationScheduleState {}

class ImmunizationScheduleLoading extends ImmunizationScheduleState {}

class ImmunizationScheduleLoaded extends ImmunizationScheduleState {
  final ImmunizationScheduleModel immunizationScheduleModel;
  @override
  List<ImmunizationScheduleModel> get props => [immunizationScheduleModel];

  ImmunizationScheduleLoaded(this.immunizationScheduleModel) : assert(immunizationScheduleModel != null);
}

class ImmunizationScheduleError extends ImmunizationScheduleState {
  final String errorMessage;
  ImmunizationScheduleError(this.errorMessage);
}