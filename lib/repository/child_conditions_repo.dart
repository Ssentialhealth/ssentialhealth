import 'package:pocket_health/models/child_conditions_model.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/services/api_service.dart';

class ChildConditionsRepo{
  final ApiService apiService;
  ChildConditionsRepo(this.apiService) : assert(apiService != null);

  Future<List<ChildConditionsModel>> getChildConditions() async {
    return await apiService.fetchChildConditions();
  }
}