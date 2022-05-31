import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/models/insurance_call_history_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FetchInsuranceCallHistoryRepo {
  final ApiService apiService;

  FetchInsuranceCallHistoryRepo(this.apiService);

  Future<List<HealthInsuranceModel>> getCallHistoryInsuranceDetails(userID) async {
    return await apiService.fetchAllInsurancesCalled(userID);
  }

  Future<List<InsuranceCallHistoryModel>> getAllCallHistory(List<HealthInsuranceModel> allInsurances, userID) async {
    final List<InsuranceCallHistoryModel> allCallHistory = await apiService.fetchAllInsuranceCallHistory(userID);

    Future<List<InsuranceCallHistoryModel>> getCallHistoryByInsuranceID() async {
      List<InsuranceCallHistoryModel> all = [];
      for (final insurance in allInsurances) {
        final history = allCallHistory.lastWhere((element) => element.id == insurance.id);
        print('--------|ended|--------|value -> ${history.endTime.toString()}');

        all.add(history);
      }
      print('--------|all|--------|value -> ${all[0].user.toString()}');

      return all;
    }

    return await getCallHistoryByInsuranceID();
  }
}
