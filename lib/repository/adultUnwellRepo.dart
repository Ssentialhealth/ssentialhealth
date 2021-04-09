import 'package:pocket_health/models/adult_unwell_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AdultUnwellRepo{
  final ApiService apiService;
  AdultUnwellRepo(this.apiService) : assert(apiService != null);

  Future<List<AdultUnwellModel>> getConditions() async {
    return await apiService.fetchConditions();
  }
}