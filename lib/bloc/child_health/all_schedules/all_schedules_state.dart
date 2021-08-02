import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/all_schedules_model.dart';

abstract class AllSchedulesState extends Equatable {
  const AllSchedulesState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AllSchedulesInitial extends AllSchedulesState {}

class AllSchedulesLoading extends AllSchedulesState {}

class AllSchedulesError extends AllSchedulesState {}

class AllSchedulesEmpty extends AllSchedulesState {}

class AllSchedulesLoaded extends AllSchedulesState {
  final List<AllScheduleModel> allSchedulesModel;

  @override
  List<AllScheduleModel> get props => allSchedulesModel;

  AllSchedulesLoaded(this.allSchedulesModel) : assert(allSchedulesModel != null);
}
