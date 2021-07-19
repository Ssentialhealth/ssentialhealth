import 'package:pocket_health/models/all_schedules_model.dart';
import 'package:pocket_health/services/api_service.dart';

class ScheduleDetailRepo {
	final ApiService apiService;

  ScheduleDetailRepo(this.apiService) : assert(apiService != null);

  Future<AllScheduleModel> getEachScheduleDetail(int id) async {
    return await apiService.fetchEachSchedule(id);
  }
}
