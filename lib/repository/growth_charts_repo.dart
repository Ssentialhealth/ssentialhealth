import 'package:pocket_health/models/child_conditions_model.dart';
import 'package:pocket_health/models/growth_chart_model.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/services/api_service.dart';

class GrowthChartsRepo{
  final ApiService apiService;
  GrowthChartsRepo(this.apiService) : assert(apiService != null);

  Future<GrowthChartModel> getGrowthCharts() async {
    return await apiService.fetchGrowthCharts();
  }
}