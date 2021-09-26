import 'package:pocket_health/models/accept_decline_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AcceptDeclineRepo {
  final ApiService apiService;

  AcceptDeclineRepo(this.apiService);

  Future<AcceptDeclineModel> acceptPatient(mapData) async {
    return await apiService.declinePatientToDB(mapData);
  }

  Future<AcceptDeclineModel> declinePatient(mapData) async {
    return await apiService.declinePatientToDB(mapData);
  }
}
