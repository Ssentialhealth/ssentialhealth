import 'package:pocket_health/models/appoinment_model.dart';
import 'package:pocket_health/services/api_service.dart';

class BookingHistoryRepo {
  final ApiService apiService;

  BookingHistoryRepo(this.apiService);

  Future<List<AppointmentModel>> getBookingHistory(int userID, int docID, int status) async {
    return await apiService.fetchBookingHistory(userID, docID, status);
  }
}
