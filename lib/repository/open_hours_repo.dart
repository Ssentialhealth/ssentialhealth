import 'package:pocket_health/models/facility_open_hours_model.dart';
import 'package:pocket_health/services/api_service.dart';

class OpenHoursRepo {
  final ApiService apiService;

  OpenHoursRepo(this.apiService);

  Future<List<FacilityOpenHoursModel>> getOpenHours(facilityID) async {
    return await apiService.fetchOpenHours(facilityID);
  }
}
