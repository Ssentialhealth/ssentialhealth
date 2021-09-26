import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/facility_appointment_model.dart';
import 'package:pocket_health/repository/facility_booking_history_repo.dart';

part 'facility_booking_history_state.dart';

class FacilityBookingHistoryCubit extends Cubit<FacilityBookingHistoryState> {
  final FacilityBookingHistoryRepo facilityBookingHistoryRepo;

  FacilityBookingHistoryCubit(this.facilityBookingHistoryRepo) : super(FacilityBookingHistoryInitial());

  void fetchFacilityAppointments({
    @required int userID,
    @required int facilityID,
    @required DateTime appointmentDate,
    @required String slotFrom,
    @required String slotTo,
    @required int status,
  }) async {
    try {
      emit(FacilityBookingHistoryLoading());
      final List<FacilityAppointmentModel> bookings = await facilityBookingHistoryRepo.getFacilityBookingHistory(userID, facilityID, status);

      emit(FacilityBookingHistorySuccess(bookings));
    } catch (_) {
      emit(FacilityBookingHistoryFailure());
      print("fetching appointments failed | $_");
    }
  }
}
