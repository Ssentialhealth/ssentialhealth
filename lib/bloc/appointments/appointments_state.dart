part of 'appointments_cubit.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();
}

class AppointmentsInitial extends AppointmentsState {
  @override
  List<Object> get props => [];
}

class AppointmentsLoading extends AppointmentsState {
  @override
  List<Object> get props => [];
}

class AppointmentsSuccess extends AppointmentsState {
  final AppointmentModel bookedAppointment;

  AppointmentsSuccess(this.bookedAppointment);
  @override
  List<Object> get props => [bookedAppointment];
}

class AppointmentsFailure extends AppointmentsState {
  @override
  List<Object> get props => [];
}
