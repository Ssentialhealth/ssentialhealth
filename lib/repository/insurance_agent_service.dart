import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/services/api_service.dart';

final insuranceAgentServiceProvider = Provider<InsuranceAgentService>((ref) {
  return InsuranceAgentService();
});

class InsuranceAgentService {
  Future<List<InsuranceAgentModel>> fetchAgents() async {
    final _token = await getStringValuesSF();
    final response = await http.get(
      "https://ssential.herokuapp.com/api/Agent/",
      headers: {
        'Authorization': 'Bearer ' + _token,
        'Content-Type': 'application/json',
      },
    );
    print('--------|reasonPhrase|--------|value -> ${response.reasonPhrase.toString()}');
    return insuranceAgentModelListFromJson(response.body);
  }
}
