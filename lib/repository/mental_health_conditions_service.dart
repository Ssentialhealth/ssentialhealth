import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/mental_health_conditions_model.dart';
import 'package:pocket_health/services/api_service.dart';

final mentalHealthConditionsServiceProvider = Provider<MentalHealthConditionsService>((ref) {
  return MentalHealthConditionsService();
});

class MentalHealthConditionsService {
  Future<List<MentalHealthConditionsModel>> fetchMentalHealthConditions() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        'https://ssential.herokuapp.com/api/MentalHealthCondition',
        headers: {
          "Authorization": "Bearer " + _token,
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        print('--------|mental health conditions json|--------|value -> ${response.body.toString()}');
        return mentalHealthConditionsModelFromJson(response.body);
      } else {
        print('--------|reason|--------|value -> ${response.reasonPhrase.toString()}');
        return null;
      }
    } catch (e, s) {
      print('--------|failed to fetch mental health conditions|--------|value -> $s');
      return throw Exception(e);
    }
  }
}
