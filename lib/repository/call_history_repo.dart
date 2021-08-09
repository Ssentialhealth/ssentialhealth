import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/services/api_service.dart';

class CallHistoryRepo {
  final ApiService apiService;

  CallHistoryRepo(this.apiService);

  Future<CallHistoryModel> registerCallHistory(CallHistoryModel callHistoryModel) async {
    return await apiService.addCallHistoryToDB(callHistoryModel);
  }

  Future<List<CallHistoryModel>> getAllCallHistory(userID) async {
    return await apiService.fetchAllCallHistory(userID);
  }
}
