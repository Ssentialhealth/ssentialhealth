import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/nutrition_chart_resources_model.dart';
import 'package:pocket_health/services/api_service.dart';

final nutritionChartResourcesServiceProvider = Provider<NutritionChartResourcesService>((ref) {
  return NutritionChartResourcesService();
});

class NutritionChartResourcesService {
  Future<List<NutritionChartResourcesModel>> getPhysicalActivityResourcesData() async {
    try {
      final _token = await getStringValuesSF();
      final response = await http.get(
        "https://ssential.herokuapp.com/api/NutritionChartResources/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('--------|json|--------|value -> ${response.body.toString()}');
        return nutritionChartResourcesModelFromJson(response.body);
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
