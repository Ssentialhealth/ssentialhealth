import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/services/api_service.dart';

class LoginRepository {
  final ApiService apiService;
  LoginRepository(this.apiService) : assert(apiService != null);

  Future<LoginModel> userLogin(String email,String password) async {
    return await apiService.login(email,password);
  }
}