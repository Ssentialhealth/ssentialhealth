import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FacilityProfileRepo {
  final ApiService apiService;

  FacilityProfileRepo(this.apiService);

  Future<List<FacilityProfileModel>> getFacilities() async {
    return apiService.fetchFacilities();
  }
}
