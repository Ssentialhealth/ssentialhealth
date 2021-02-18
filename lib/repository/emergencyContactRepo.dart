import 'package:pocket_health/models/emergency_contact.dart';
import 'package:pocket_health/repository/userProfile_repo.dart';
import 'package:pocket_health/services/api_service.dart';

class EmergencyContactRepo {
  final ApiService apiService;
  EmergencyContactRepo(this.apiService): assert(apiService != null);

  Future<EmergencyContact> addContacts(
      String ambulanceName,
      String countryCode,
      String ambulancePhone,
      String insurerName,
      String insuranceNumber,
      String insurerNumber,
      String emergenceName,
      String emergencyRelation,
      String emergencyNumber,
      )async {
    return await apiService.addContacts(ambulanceName, countryCode, ambulancePhone, insurerName, insuranceNumber, insurerNumber, emergenceName, emergencyRelation, emergencyNumber
    );
  }
}