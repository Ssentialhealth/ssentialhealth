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
  //Health//
  String healthInstitution,
  String careType,
  String practitioner,
  String speciality,
  String affiliatedInstitution,
  //Provider//
  String operationTime,
  //online Booking//
  String onlinePrice,
  String onlinePriceB,
  String onlinePriceC,
  //InPerson Booking//
  String personalPrice,
  String personalBPrice,
  //Follow Up//
  String followPrice,
  String followBPrice,
      ) async {
    return await apiService.createPractitioner(
        surname, location, region, phone, healthInstitution, careType, practitioner, speciality, affiliatedInstitution, operationTime,onlinePrice,personalPrice,followPrice,
      onlinePriceB,onlinePriceC,personalBPrice,followBPrice
    );
  }
}