import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FetchCallHistoryRepo {
	final ApiService apiService;

  FetchCallHistoryRepo(this.apiService);

  Future<List<PractitionerProfileModel>> getCallHistoryByuserID(userID) async {
    return await apiService.fetchAllCallHistory(userID);
  }

  Future<PractitionerProfileModel> getDocDetails(docID) async {
    return await apiService.fetchDocDetails(docID);
  }
}
