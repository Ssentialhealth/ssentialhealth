import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FetchFacilityCallHistoryRepo {
  final ApiService apiService;

  FetchFacilityCallHistoryRepo(this.apiService);

  Future<List<FacilityProfileModel>> getCallHistoryFacilityDetails(userID) async {
    return await apiService.fetchAllFacilitiesCalled(userID);
  }

  Future<List<FacilityCallHistoryModel>> getAllCallHistory(List<FacilityProfileModel> allFacilities, userID) async {
    final List<FacilityCallHistoryModel> allCallHistory = await apiService.fetchAllFacilityCallHistory(userID);

    Future<List<FacilityCallHistoryModel>> getCallHistoryByFacilityID() async {
      List<FacilityCallHistoryModel> all = [];
      for (final facility in allFacilities) {
        final history = allCallHistory.lastWhere((element) => element.facility == facility.id);
        print('--------|ended|--------|value -> ${history.endTime.toString()}');

        all.add(history);
      }
      print('--------|all|--------|value -> ${all[0].user.toString()}');

      return all;
    }

    return await getCallHistoryByFacilityID();
  }
}
