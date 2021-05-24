import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/services/api_service.dart';

class NutritionRepo{
  final ApiService apiService;
  NutritionRepo(this.apiService) : assert(apiService != null);

  Future<List<NutritionModel>> getNutrition() async {
    return await apiService.fetchNutrition();
  }
}