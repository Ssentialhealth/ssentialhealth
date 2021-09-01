import 'package:flutter/material.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class PractitionerProfileRepo {
  final ApiService apiService;

  PractitionerProfileRepo(this.apiService) : assert(apiService != null);

  Future<PractitionerProfileModel> createPractitionerProfile(
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
    return await apiService.createPractitioner(surname, location, region, phone, healthInstitution, careType, practitioner, speciality, affiliatedInstitution,
        operationTime, onlinePrice, personalPrice, followPrice, onlinePriceB, onlinePriceC, personalBPrice, followBPrice);
  }

  Future<List<PractitionerProfileModel>> getPractitioners() async {
    return await apiService.fetchPractitioners();
  }

  Future<List<PractitionerProfileModel>> filterPractitioners({
    @required String filterByDistance,
    @required String practitionersCategory,
    @required String filterByPrice,
    @required String filterByAvailability,
    @required String sortByNearest,
    @required String sortByHighestRated,
    @required String sortByCheapest,
    @required String filterBySpeciality,
  }) async {
    return await apiService.fetchFilteredPractitioners(
        filterByDistance: filterByDistance,
        filterByPrice: filterByPrice,
        filterByAvailability: filterByAvailability,
        filterBySpeciality: filterBySpeciality,
        sortByCheapest: sortByCheapest,
        sortByHighestRated: sortByHighestRated,
        sortByNearest: sortByNearest,
        practitionersCategory: practitionersCategory);
  }
}
