import 'package:pocket_health/models/child_conditions_model.dart';
import 'package:pocket_health/models/delayed_milestone_model.dart';
import 'package:pocket_health/models/growth_chart_model.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/services/api_service.dart';

class DelayedMilestonesRepo{
  final ApiService apiService;
  DelayedMilestonesRepo(this.apiService) : assert(apiService != null);

  Future<DelayedMilestoneModel> getDelayedMilestones() async {
    return await apiService.fetchDelayedMilestones();
  }
}