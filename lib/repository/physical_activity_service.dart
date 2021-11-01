import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/physical_activity_model.dart';
import 'package:pocket_health/services/api_service.dart';

final physicalActivityServiceProvider = Provider<PhysicalActivityService>((ref) {
  return PhysicalActivityService();
});

class PhysicalActivityService {
  Future<PhysicalActivityModel> getPhysicalActivityData() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/PhysicalActivity/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('--------|json|--------|value -> ${response.body.toString()}');
        return physicalActivityModelFromJson(response.body)[0];
      } else {
        print('--------|failure reason|--------|value -> ${response.reasonPhrase.toString()}');
        return null;
      }
    } catch (e, s) {
      print('--------|failed to fetch|--------|value -> $s');
      return throw Exception(e);
    }
  }
}
