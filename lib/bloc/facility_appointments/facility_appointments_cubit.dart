import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/facility_appointment_model.dart';
import 'package:pocket_health/repository/facility_appointments_repo.dart';

part 'facility_appointments_state.dart';

class FacilityAppointmentsCubit extends Cubit<FacilityAppointmentsState> {
  final FacilityAppointmentsRepo facilityAppointmentsRepo;

  FacilityAppointmentsCubit(this.facilityAppointmentsRepo) : super(FacilityAppointmentsInitial());

  void bookFacilityAppointment({
    @required DateTime appointmentDate,
    @required String slotFrom,
    @required String slotTo,
    @required int status,
    @required int appointmentType,
    @required int userID,
    @required int facilityID,
  }) async {
    try {
      emit(FacilityAppointmentsLoading());

      final appointmentToBook = FacilityAppointmentModel(
        appointmentDate: appointmentDate,
        timeSlotFrom: slotFrom,
        timeSlotTo: slotTo,
        status: status,
        appointmentType: appointmentType,
        user: userID,
        facility: facilityID,
      );

      final bookedAppointment = await facilityAppointmentsRepo.addFacilityAppointment(appointmentToBook);

      emit(FacilityAppointmentsSuccess(bookedAppointment));
    } catch (_) {
      emit(FacilityAppointmentsFailure());
      print("booking appointment failed | $_");
    }
  }
}
