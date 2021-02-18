import 'package:pocket_health/models/PractitionerProfile.dart';
import 'package:pocket_health/services/api_service.dart';

class PractitionerProfileRepo {
  final ApiService apiService;
  PractitionerProfileRepo(this.apiService) : assert(apiService != null);

  Future<PractitionerProfile> createPractitionerProfile(
      String surname,
      String location,
      String region,
      String phone,
      String healthInstitution,
      String careType,
      String practitioner,
      String speciality,
      String affiliatedInstitution,
      String operationTime,
      String onlineBooking,
      String inPerson,
      String followUp,
      String onlinePrice,
      String personalPrice,
      String followPrice,
      ) async {
    return await apiService.createPractitioner(
        surname, location, region, phone, healthInstitution, careType, practitioner, speciality, affiliatedInstitution, operationTime, onlineBooking, inPerson, followUp,onlinePrice,personalPrice,followPrice
    );
  }
}