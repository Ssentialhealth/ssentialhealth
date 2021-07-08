
import 'package:pocket_health/models/immunization_schedule_model.dart';
import 'package:pocket_health/services/api_service.dart';

class ImmunizationScheduleRepo{
  final ApiService apiService;
  ImmunizationScheduleRepo(this.apiService) : assert(apiService != null);

  Future<ImmunizationScheduleModel> createSchedule(String childName, String childDob)async{
    return await apiService.createSchedule(childName, childDob);
  }

}