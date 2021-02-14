import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/services/api_service.dart';

class UserProfileRepo {
  final ApiService apiService;
  UserProfileRepo(this.apiService) : assert(apiService != null);

  Future<Profile> createUserProfile(
      String surname,
      String phone,
      String dob,
      String gender,
      String residence,
      String country,
      String blood,
      String chronic,
      String longTerm,
      String date,
      String condition,
      String code,
      String dissabilities,
      String recreational,
      String drugAllergies,
      String foodAllergies,
      ) async {
    return await apiService.createProfile(
      surname,phone,dob,gender,residence,country,blood,chronic,longTerm,date,condition,code,dissabilities,recreational,drugAllergies,foodAllergies
    );
  }



}