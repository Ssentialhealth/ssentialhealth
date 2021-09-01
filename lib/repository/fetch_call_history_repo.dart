import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FetchCallHistoryRepo {
  final ApiService apiService;

  FetchCallHistoryRepo(this.apiService);

  Future<List<PractitionerProfileModel>> getCallHistoryDocDetails(userID) async {
    return await apiService.fetchAllDoctorsCalled(userID);
  }

  Future<List<CallHistoryModel>> getAllCallHistory(List<PractitionerProfileModel> allDocs, userID) async {
    final allCallHistory = await apiService.fetchAllCallHistory(userID);

    Future<List<CallHistoryModel>> getCallHistoryByDocID() async {
      List<CallHistoryModel> all = [];
      for (final doc in allDocs) {
        final history = allCallHistory.lastWhere((element) => element.profile == doc.user);
        print('--------|ended|--------|value -> ${history.endTime.toString()}');

        all.add(history);
      }
      print('--------|all|--------|value -> ${all[0].user.toString()}');

      return all;
    }

    return await getCallHistoryByDocID();
  }
}
