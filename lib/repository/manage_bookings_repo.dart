import 'package:pocket_health/models/accept_decline_model.dart';
import 'package:pocket_health/models/doc_bookings.dart';
import 'package:pocket_health/services/api_service.dart';

class ManageBookingsRepo {
  final ApiService apiService;

  ManageBookingsRepo(this.apiService);

  Future<List<DocBookings>> getBookingsByID(id) async {
    return await apiService.fetchBookingsByID(id);
  }

  Future<List<AcceptDeclineModel>> getAllPatientBookings() async {
    return await apiService.fetchAllPatientBookings();
  }

  Future<List<DocBookings>> getAcceptedBookings(List<DocBookings> allBookings, patientBookings) async {
    final acceptedPatientBookings = patientBookings.where((element) => element.waitingStatus == true)?.toList();
    Future<List<DocBookings>> confirmBookingIsAccepted() async {
      List<DocBookings> all = [];
      for (final acc in acceptedPatientBookings) {
        final accepted = allBookings?.where((element) => element.user == acc.user)?.toList();
        all = accepted;
      }
      return all;
    }

    return await confirmBookingIsAccepted();
  }

  Future<List<DocBookings>> getDeclinedBookings(List<DocBookings> allBookings, patientBookings) async {
    final rejectedPatientBookings = patientBookings.where((element) => element.waitingStatus == false).toList();

    Future<List<DocBookings>> confirmBookingIsRejected() async {
      List<DocBookings> all = [];
      for (final acc in rejectedPatientBookings) {
        final rejected = allBookings?.where((element) => element.user == acc.user)?.toList();
        all = rejected;
      }
      return all;
    }

    return await confirmBookingIsRejected();
  }

  Future<List<DocBookings>> getPendingBookings(List<DocBookings> allBookings, patientBookings) async {
    final rejectedPatientBookings = patientBookings?.where((element) => element?.waitingStatus == false)?.toList();
    final acceptedPatientBookings = patientBookings?.where((element) => element?.waitingStatus == true)?.toList();

    Future<List<DocBookings>> confirmBookingIsRejected() async {
      List<DocBookings> rejectedRemoved = [];
      List<DocBookings> acceptedRemoved = [];
      for (final rej in rejectedPatientBookings) {
        allBookings?.remove(rej);
        rejectedRemoved = allBookings;
      }

      for (final acc in acceptedPatientBookings) {
        rejectedRemoved?.remove(acc);
        acceptedRemoved = allBookings;
      }

      return acceptedRemoved;
    }

    return await confirmBookingIsRejected();
  }
}
