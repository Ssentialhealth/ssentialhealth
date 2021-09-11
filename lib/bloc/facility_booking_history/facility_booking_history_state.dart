part of 'facility_booking_history_cubit.dart';

abstract class FacilityBookingHistoryState extends Equatable {
  const FacilityBookingHistoryState();
}

class FacilityBookingHistoryInitial extends FacilityBookingHistoryState {
  @override
  List<Object> get props => [];
}

class FacilityBookingHistoryLoading extends FacilityBookingHistoryState {
  @override
  List<Object> get props => [];
}

class FacilityBookingHistorySuccess extends FacilityBookingHistoryState {
  final List<FacilityAppointmentModel> bookings;

  FacilityBookingHistorySuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class FacilityBookingHistoryFailure extends FacilityBookingHistoryState {
  @override
  List<Object> get props => [];
}
