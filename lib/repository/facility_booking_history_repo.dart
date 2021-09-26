import 'package:pocket_health/models/facility_appointment_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FacilityBookingHistoryRepo {
  final ApiService apiService;

  FacilityBookingHistoryRepo(this.apiService);

  Future<List<FacilityAppointmentModel>> getFacilityBookingHistory(int userID, int facilityID, int status) async {
    return await apiService.fetchFacilityBookingHistory(userID, facilityID, status);
  }
}
