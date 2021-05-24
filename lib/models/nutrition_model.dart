// To parse this JSON data, do
//
//     final nutritionModel = nutritionModelFromJson(jsonString);

import 'dart:convert';

List<NutritionModel> nutritionModelFromJson(String str) => List<NutritionModel>.from(json.decode(str).map((x) => NutritionModel.fromJson(x)));

String nutritionModelToJson(List<NutritionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NutritionModel {
  NutritionModel({
    this.id,
    this.phase,
    this.nutrition,
  });

  int id;
  String phase;
  List<String> nutrition;

  factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
    id: json["id"],
    phase: json["phase"],
    nutrition: List<String>.from(json["nutrition"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phase": phase,
    "nutrition": List<dynamic>.from(nutrition.map((x) => x)),
  };
}
