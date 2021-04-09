import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/services/api_service.dart';

class ConditionDetailsRepo{
  final ApiService apiService;
  ConditionDetailsRepo(this.apiService) : assert(apiService != null);

  Future<ConditionDetails> getConditionDetails(int id) async {
    return await apiService.fetchConditionDetails(id);
  }
}