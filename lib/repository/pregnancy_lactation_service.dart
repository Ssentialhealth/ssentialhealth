import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/pregnancy_health_conditions_model.dart';
import 'package:pocket_health/models/pregnancy_lactation_model.dart';
import 'package:pocket_health/models/pregnancy_lactation_resources_model.dart';
import 'package:pocket_health/services/api_service.dart';

final pregServiceProvider = Provider<PregnancyLactationService>((ref) {
  return PregnancyLactationService();
});

class PregnancyLactationService {
  Future<PregnancyLactationModel> getPregnancyLactationInfo() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/PregnancyLactation/5/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      print('--------|reason.phrase|--------|value -> ${response.reasonPhrase.toString()}');
      return pregnancyLactationModelFromJson(response.body);
    } catch (_, w) {
      print('--------|err|--------|value -> ${w.toString()}');
      return null;
    }
  }

  Future<List<PregnancyHealthConditionsModel>> getPregnancyHealthConditions() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/PregnancyHealthCondition/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      print('--------|reason.phrase|--------|value -> ${response.reasonPhrase.toString()}');
      return pregnancyHealthConditionsModelFromJson(response.body);
    } catch (_, w) {
      print('--------|err|--------|value -> ${w.toString()}');
      return null;
    }
  }

  Future<List<PregnancyLactationResourcesModel>> getPregnancyLactationResources() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/PregnancyLactationResources/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      print('--------|reason.phrase|--------|value -> ${response.reasonPhrase.toString()}');
      return pregnancyLactationResourcesModelFromJson(response.body);
    } catch (_, w) {
      print('--------|err|--------|value -> ${w.toString()}');
      return null;
    }
  }
}
