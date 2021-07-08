import 'package:pocket_health/models/all_schedules_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AllScheduleRepo{
  final ApiService apiService;
  AllScheduleRepo(this.apiService) : assert(apiService != null);

  Future<List<AllScheduleModel>> getAllSchedules() async {
    return await apiService.fetchAllSchedule();
  }
}