import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/nutrition_wellness_service.dart';

List<NutritionWellnessModel> nutritionWellnessModelFromJson(String str) =>
    List<NutritionWellnessModel>.from(json.decode(str).map((x) => NutritionWellnessModel.fromJson(x)));
String nutritionWellnessModelToJson(List<NutritionWellnessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final nutritionWellnessModelProvider = FutureProvider.autoDispose<NutritionWellnessModel>((ref) async {
  final service = ref.watch(nutritionWellnessServiceProvider);
  final data = await service.getNutritionWellnessData();
  return data;
});

class NutritionWellnessModel {
  NutritionWellnessModel({
    @required this.id,
    @required this.basicOverview,
    @required this.basicLink,
    @required this.foodProductsOverview,
    @required this.foodProductsLink,
    @required this.weightGainLossOverview,
    @required this.weightGainLossLink,
  });

  final int id;
  final String basicOverview;
  final int basicLink;
  final String foodProductsOverview;
  final int foodProductsLink;
  final String weightGainLossOverview;
  final int weightGainLossLink;

  factory NutritionWellnessModel.fromJson(Map<String, dynamic> json) => NutritionWellnessModel(
        id: json["id"],
        basicOverview: json["basic_overview"],
        basicLink: json["basic_link"],
        foodProductsOverview: json["food_products_overview"],
        foodProductsLink: json["food_products_link"],
        weightGainLossOverview: json["weight_gain_loss_overview"],
        weightGainLossLink: json["weight_gain_loss_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "basic_overview": basicOverview,
        "basic_link": basicLink,
        "food_products_overview": foodProductsOverview,
        "food_products_link": foodProductsLink,
        "weight_gain_loss_overview": weightGainLossOverview,
        "weight_gain_loss_link": weightGainLossLink,
      };
}
