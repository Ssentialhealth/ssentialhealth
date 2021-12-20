import 'package:pocket_health/models/insurance_call_history_model.dart';
import 'package:pocket_health/services/api_service.dart';

class InsuranceCallHistoryRepo {
  final ApiService apiService;

  InsuranceCallHistoryRepo(this.apiService);

  Future<InsuranceCallHistoryModel> registerInsuranceCallHistory(Map<String, dynamic> mapData) async {
    return await apiService.addInsuranceCallHistoryToDB(mapData);
  }
}
