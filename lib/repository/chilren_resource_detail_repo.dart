import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/models/child_resource_detail_model.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/services/api_service.dart';

class ChildResourceDetailRepo{
  final ApiService apiService;
  ChildResourceDetailRepo(this.apiService) : assert(apiService != null);

  Future<ChildResourceDetailModel> getResourceDetails(int id) async {
    return await apiService.fetchResourceDetails(id);
  }
}