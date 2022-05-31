import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/services/api_service.dart';

final healthInsuranceServiceProvider = Provider<HealthInsuranceService>((ref) {
  return HealthInsuranceService();
});

class HealthInsuranceService {
  Future<List<HealthInsuranceModel>> fetchHealthInsurances() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/HealthInsuarance/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      print('--------|reasonPhrase|--------|value -> ${response.reasonPhrase.toString()}');
      return healthInsuranceModelListFromJson(response.body);
    } catch (e, s) {
      print('--------|failed to fetch|--------|value -> $s');
      return throw Exception();
    }
  }
}
