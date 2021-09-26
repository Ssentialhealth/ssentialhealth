import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/doc_bookings.dart';
import 'package:pocket_health/repository/manage_bookings_repo.dart';

part 'manage_bookings_state.dart';

class ManageBookingsCubit extends Cubit<ManageBookingsState> {
  final ManageBookingsRepo manageBookingsRepo;

  ManageBookingsCubit(this.manageBookingsRepo) : super(ManageBookingsInitial());

  void loadBookingsById(id) async {
    try {
      emit(ManageBookingsLoading());
      final allDocBookings = await manageBookingsRepo.getBookingsByID(id);
      final patientBookings = await manageBookingsRepo.getAllPatientBookings();
      final accepted = await manageBookingsRepo.getAcceptedBookings(allDocBookings, patientBookings);
      final declined = await manageBookingsRepo.getDeclinedBookings(allDocBookings, patientBookings);
      final pending = await manageBookingsRepo.getPendingBookings(allDocBookings, patientBookings);

      emit(ManageBookingsSuccess(
        allBookings: allDocBookings,
        accepted: accepted,
        pending: pending,
        declined: declined,
      ));
    } catch (_) {
      emit(ManageBookingsFailure());
      print(" loading docBookings failed| ${_}");
      throw Exception(_);
    }
  }
}
