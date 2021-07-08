import 'package:pocket_health/models/children_resources_model.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/services/api_service.dart';

class ChildResourceRepo{
  final ApiService apiService;
  ChildResourceRepo(this.apiService) : assert(apiService != null);

  Future<List<ChildResourceModel>> getResources() async {
    return await apiService.fetchChildResource();
  }
}