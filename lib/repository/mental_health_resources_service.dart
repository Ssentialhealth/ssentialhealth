import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/screens/mental_health/mental_health_resources_model.dart';
import 'package:pocket_health/services/api_service.dart';

final mentalHealthResourcesServiceProvider = Provider<MentalHealthResourcesService>((ref) {
  return MentalHealthResourcesService();
});

class MentalHealthResourcesService {
  Future<List<MentalHealthResourcesModel>> fetchMentalResources() async {
    try {
      final _token = getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/MentalHealthResources/",
        headers: {
          "Authorization": "Bearer " + _token,
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        print('--------|json|--------|value -> ${response.body.toString()}');
        return mentalResourcesModelFromJson(response.body);
      } else {
        print('--------|failure reason|--------|value -> ${response.reasonPhrase.toString()}');
        return null;
      }
    } catch (e, s) {
      print('--------|failed to fetch|--------|value -> $s');
      return null;
    }
  }
}
