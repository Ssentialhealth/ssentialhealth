import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FacilityCallHistoryRepo {
  final ApiService apiService;

  FacilityCallHistoryRepo(this.apiService);

  Future<FacilityCallHistoryModel> registerFacilityCallHistory(Map<String, dynamic> mapData) async {
    return await apiService.addFacilityCallHistoryToDB(mapData);
  }
}
