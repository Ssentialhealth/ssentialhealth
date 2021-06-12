import 'package:pocket_health/models/Schedule_detail_model.dart';
import 'package:pocket_health/services/api_service.dart';

class ScheduleDetailRepo{
  final ApiService apiService;
  ScheduleDetailRepo(this.apiService) : assert(apiService != null);

  Future<ScheduleDetail> getScheduleDetail(int id) async {
    return await apiService.fetchScheduleById(id);
  }
}