part of 'booking_history_cubit.dart';

abstract class BookingHistoryState extends Equatable {
  const BookingHistoryState();
}

class BookingHistoryInitial extends BookingHistoryState {
  @override
  List<Object> get props => [];
}

class BookingHistoryLoading extends BookingHistoryState {
  @override
  List<Object> get props => [];
}

class BookingHistorySuccess extends BookingHistoryState {
  final List<AppointmentModel> bookings;

  BookingHistorySuccess(this.bookings);
  @override
  List<Object> get props => [bookings];
}

class BookingHistoryFailure extends BookingHistoryState {
  @override
  List<Object> get props => [];
}
