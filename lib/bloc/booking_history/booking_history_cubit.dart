import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/appoinment_model.dart';
import 'package:pocket_health/repository/booking_history_repo.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final BookingHistoryRepo bookingHistoryRepo;
  BookingHistoryCubit(this.bookingHistoryRepo) : super(BookingHistoryInitial());

  void fetchAppointments({
    @required int userID,
    @required int docID,
    @required DateTime appointmentDate,
    @required String slotFrom,
    @required String slotTo,
    @required int status,
  }) async {
    try {
      emit(BookingHistoryLoading());

      //fetch appointments to check previously booked slots

      final List<AppointmentModel> bookings = await bookingHistoryRepo.getBookingHistory(userID, docID, status);

      emit(BookingHistorySuccess(bookings));
    } catch (_) {
      emit(BookingHistoryFailure());
      print("fetching appointments failed | $_");
    }
  }
}
