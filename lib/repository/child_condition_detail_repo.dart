import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/services/api_service.dart';

class ChildConditionDetailRepo{
  final ApiService apiService;
  ChildConditionDetailRepo(this.apiService) : assert(apiService != null);

  Future<ChildConditionsDetailModel> getConditionDetails(int id) async {
    return await apiService.fetchChildConditionDetails(id);
  }
}