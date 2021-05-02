

import 'package:pocket_health/models/search_condition_model.dart';
import 'package:pocket_health/services/api_service.dart';

class SearchConditionRepo{
  final ApiService apiService;
  SearchConditionRepo(this.apiService) : assert(apiService != null);

  Future<List<SearchCondition>> getConditions(String condition) async {
    return await apiService.fetchSearchedCondition(condition);
  }

}