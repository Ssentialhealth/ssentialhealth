import 'package:pocket_health/models/facility_appointment_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FacilityAppointmentsRepo {
  final ApiService apiService;

  FacilityAppointmentsRepo(this.apiService);

  Future<FacilityAppointmentModel> addFacilityAppointment(FacilityAppointmentModel appointment) async {
    return await apiService.bookFacilityAppointment(appointment);
  }
}
