// To parse this JSON data, do
//
//     final nutritionModel = nutritionModelFromJson(jsonString);

import 'dart:convert';

List<NutritionModel> nutritionModelFromJson(String str) => List<NutritionModel>.from(json.decode(str).map((x) => NutritionModel.fromJson(x)));

String nutritionModelToJson(List<NutritionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NutritionModel {
  NutritionModel({
    this.id,
    this.the06Months,
    this.the612Months,
  });

  int id;
  List<String> the06Months;
  List<String> the612Months;

  factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
    id: json["id"],
    the06Months: json["0-6 months"] == null ? null : List<String>.from(json["0-6 months"].map((x) => x)),
    the612Months: json["6-12 months"] == null ? null : List<String>.from(json["6-12 months"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "0-6 months": the06Months == null ? null : List<dynamic>.from(the06Months.map((x) => x)),
    "6-12 months": the612Months == null ? null : List<dynamic>.from(the612Months.map((x) => x)),
  };
}
