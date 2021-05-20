import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AdultUnwellRepo{
  final ApiService apiService;
  AdultUnwellRepo(this.apiService) : assert(apiService != null);

  Future<List<SymptomModel>> getConditions() async {
    return await apiService.fetchConditions();
  }
}