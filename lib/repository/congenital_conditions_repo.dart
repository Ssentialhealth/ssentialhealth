import 'package:pocket_health/models/child_chronic_condition_model.dart';
import 'package:pocket_health/models/child_conditions_model.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/services/api_service.dart';

class CongenitalConditionsRepo{
  final ApiService apiService;
  CongenitalConditionsRepo(this.apiService) : assert(apiService != null);

  Future<List<CongenitalConditionsModel>> getCongenitalConditions() async {
    return await apiService.fetchCongenitalConditions();
  }
}