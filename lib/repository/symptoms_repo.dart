

import 'package:pocket_health/models/symptoms_detail_model.dart';
import 'package:pocket_health/services/api_service.dart';

class SymptomDetailsRepo{
  final ApiService apiService;
  SymptomDetailsRepo(this.apiService) : assert(apiService != null);

  Future<SymptomDetail> getSymptomDetails(int id) async {
    return await apiService.fetchSymptomsDetails(id);
  }
}