import 'package:pocket_health/models/child_chronic_detail_model.dart';
import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/services/api_service.dart';

class CongenitalConditionDetailRepo{
  final ApiService apiService;
  CongenitalConditionDetailRepo(this.apiService) : assert(apiService != null);

  Future<CongenitalDetailModel> getCongenitalConditionDetails(int id) async {
    return await apiService.fetchCongenitalDetails(id);
  }
}