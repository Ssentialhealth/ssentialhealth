import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/appoinment_model.dart';
import 'package:pocket_health/repository/appointments_repo.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsRepo appointmentsRepo;
  AppointmentsCubit(this.appointmentsRepo) : super(AppointmentsInitial());

  void bookAppointment({
    @required DateTime appointmentDate,
    @required String slotFrom,
    @required String slotTo,
    @required int status,
    @required int appointmentType,
    @required int userID,
    @required int docID,
  }) async {
    try {
      emit(AppointmentsLoading());

      final appointmentToBook = AppointmentModel(
	      appointmentDate: appointmentDate,
        timeSlotFrom: slotFrom,
        timeSlotTo: slotTo,
        status: status,
        appointmentType: appointmentType,
        user: userID,
        profile: docID,
      );

      final bookedAppointment = await appointmentsRepo.addAppointment(appointmentToBook);

      emit(AppointmentsSuccess(bookedAppointment));
    } catch (_) {
      emit(AppointmentsFailure());
      print("booking appointment failed | $_");
    }
  }
}
