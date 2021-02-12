import 'package:pocket_health/models/ForgotPassword.dart';
import 'package:pocket_health/services/api_service.dart';

class ForgotPasswordRepo {
  final ApiService apiService;
  ForgotPasswordRepo(this.apiService) : assert(apiService != null);

  Future<ForgotPassword> resetUserPassword(String email) async {
    return await apiService.resetPassword(email);
  }
}