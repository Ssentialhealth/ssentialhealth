part of 'list_facility_open_hours_cubit.dart';

abstract class ListFacilityOpenHoursState extends Equatable {
  const ListFacilityOpenHoursState();
}

class ListFacilityOpenHoursInitial extends ListFacilityOpenHoursState {
  @override
  List<Object> get props => [];
}

class ListFacilityOpenHoursLoading extends ListFacilityOpenHoursState {
  @override
  List<Object> get props => [];
}

class ListFacilityOpenHoursFailure extends ListFacilityOpenHoursState {
  @override
  List<Object> get props => [];
}

class ListFacilityOpenHoursSuccess extends ListFacilityOpenHoursState {
  final List<FacilityOpenHoursModel> openHours;

  ListFacilityOpenHoursSuccess(this.openHours);

  @override
  List<Object> get props => [openHours];
}
