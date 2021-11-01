// To parse this JSON data, do
//
//     final nutritionChartResourcesModel = nutritionChartResourcesModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/nutrition_chart_resources_service.dart';

List<NutritionChartResourcesModel> nutritionChartResourcesModelFromJson(String str) =>
    List<NutritionChartResourcesModel>.from(json.decode(str).map((x) => NutritionChartResourcesModel.fromJson(x)));

String nutritionChartResourcesModelToJson(List<NutritionChartResourcesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final nutritionChartResourcesModelProvider = FutureProvider.autoDispose<List<NutritionChartResourcesModel>>((ref) async {
  final service = ref.watch(nutritionChartResourcesServiceProvider);
  final data = await service.getPhysicalActivityResourcesData();
  return data;
});

class NutritionChartResourcesModel {
  NutritionChartResourcesModel({
    @required this.id,
    @required this.nutritionChartResources,
    @required this.resourceLink,
  });

  final int id;
  final String nutritionChartResources;
  final int resourceLink;

  factory NutritionChartResourcesModel.fromJson(Map<String, dynamic> json) => NutritionChartResourcesModel(
        id: json["id"],
        nutritionChartResources: json["nutrition_chart_resources"],
        resourceLink: json["resource_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nutrition_chart_resources": nutritionChartResources,
        "resource_link": resourceLink,
      };
}
