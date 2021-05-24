import 'package:pocket_health/models/normal_development_Model.dart';
import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/services/api_service.dart';

class NormalDevelopmentRepo{
  final ApiService apiService;
  NormalDevelopmentRepo(this.apiService) : assert(apiService != null);

  Future<NormalDevelopmentModel> getNormalDevelopment() async {
    return await apiService.fetchNormalDevelopment();
  }
}