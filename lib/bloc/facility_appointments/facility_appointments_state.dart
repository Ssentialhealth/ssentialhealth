part of 'facility_appointments_cubit.dart';

abstract class FacilityAppointmentsState extends Equatable {
  const FacilityAppointmentsState();
}

class FacilityAppointmentsInitial extends FacilityAppointmentsState {
  @override
  List<Object> get props => [];
}

class FacilityAppointmentsSuccess extends FacilityAppointmentsState {
  final FacilityAppointmentModel facilityAppointmentModel;

  FacilityAppointmentsSuccess(this.facilityAppointmentModel);

  @override
  List<Object> get props => [facilityAppointmentModel];
}

class FacilityAppointmentsLoading extends FacilityAppointmentsState {
  @override
  List<Object> get props => [];
}

class FacilityAppointmentsFailure extends FacilityAppointmentsState {
  @override
  List<Object> get props => [];
}
