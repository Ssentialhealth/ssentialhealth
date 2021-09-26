part of 'manage_bookings_cubit.dart';

abstract class ManageBookingsState extends Equatable {
  const ManageBookingsState();
}

class ManageBookingsInitial extends ManageBookingsState {
  @override
  List<Object> get props => [];
}

class ManageBookingsLoading extends ManageBookingsState {
  @override
  List<Object> get props => [];
}

class ManageBookingsSuccess extends ManageBookingsState {
  final List<DocBookings> allBookings;
  final List<DocBookings> pending;
  final List<DocBookings> accepted;
  final List<DocBookings> declined;

  ManageBookingsSuccess({this.pending, this.accepted, this.declined, this.allBookings});

  @override
  List<Object> get props => [allBookings, pending, accepted, declined];
}

class ManageBookingsFailure extends ManageBookingsState {
  @override
  List<Object> get props => [];
}
