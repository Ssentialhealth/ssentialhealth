import 'package:flutter/cupertino.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FacilityProfileRepo {
  final ApiService apiService;

  FacilityProfileRepo(this.apiService);

  Future<List<FacilityProfileModel>> getFacilities(filterByFacilityType) async {
    return apiService.fetchFacilities(filterByFacilityType);
  }

  Future<List<FacilityProfileModel>> filterFacilities({
    @required String filterByDistance,
    @required String facilityCategory,
    @required String filterByPrice,
    @required String filterByAvailability,
    @required String sortByNearest,
    @required String sortByHighestRated,
    @required String sortByCheapest,
    @required String filterBySpeciality,
    @required String filterFacilitiesByCountry,
  }) async {
    return await apiService.fetchFilteredFacilities(
      filterByDistance: filterByDistance,
      filterByPrice: filterByPrice,
      filterByAvailability: filterByAvailability,
      filterBySpeciality: filterBySpeciality,
      sortByCheapest: sortByCheapest,
      sortByHighestRated: sortByHighestRated,
      sortByNearest: sortByNearest,
      filterByFacilityType: facilityCategory,
      filterByCountry: filterFacilitiesByCountry,
    );
  }
}
