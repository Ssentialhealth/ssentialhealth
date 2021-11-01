import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/nutrition_wellness_model.dart';
import 'package:pocket_health/services/api_service.dart';

final nutritionWellnessServiceProvider = Provider<NutritionWellnessService>((ref) {
  return NutritionWellnessService();
});

class NutritionWellnessService {
  Future<NutritionWellnessModel> getNutritionWellnessData() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/Nutrition/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('--------|json|--------|value -> ${response.body.toString()}');
        return nutritionWellnessModelFromJson(response.body)[0];
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
