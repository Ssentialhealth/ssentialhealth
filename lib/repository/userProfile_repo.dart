import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/services/api_service.dart';

class UserProfileRepo {
  final ApiService apiService;
  UserProfileRepo(this.apiService) : assert(apiService != null);

  Future<Profile> createUserProfile() async {
    return await apiService.createProfile(

    );
  }
}