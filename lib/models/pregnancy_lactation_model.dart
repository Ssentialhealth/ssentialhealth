// To parse this JSON data, do
//
//     final pregnancyLactationModel = pregnancyLactationModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/pregnancy_lactation_service.dart';

PregnancyLactationModel pregnancyLactationModelFromJson(String str) => PregnancyLactationModel.fromJson(json.decode(str));

String pregnancyLactationModelToJson(PregnancyLactationModel data) => json.encode(data.toJson());

final AutoDisposeFutureProvider<PregnancyLactationModel> pregModelProvider = FutureProvider.autoDispose<PregnancyLactationModel>((ref) async {
  final pregService = ref.watch(pregServiceProvider);
  final data = await pregService.getPregnancyLactationInfo();
  return data;
});

class PregnancyLactationModel {
  PregnancyLactationModel({
    @required this.id,
    @required this.menstrualCycleOrPeriodCycle,
    @required this.normalPregnancyOrLactation,
    @required this.mentalWellness,
    @required this.physicalWellness,
    @required this.nutritionWellness,
  });

  final int id;
  final String menstrualCycleOrPeriodCycle;
  final String normalPregnancyOrLactation;
  final String mentalWellness;
  final String physicalWellness;
  final String nutritionWellness;

  factory PregnancyLactationModel.fromJson(Map<String, dynamic> json) => PregnancyLactationModel(
    id: json["id"],
    menstrualCycleOrPeriodCycle: json["menstrual_cycle_or_period_cycle"],
    normalPregnancyOrLactation: json["normal_pregnancy_or_lactation"],
    mentalWellness: json["mental_wellness"],
    physicalWellness: json["physical_wellness"],
    nutritionWellness: json["nutrition_wellness"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menstrual_cycle_or_period_cycle": menstrualCycleOrPeriodCycle,
    "normal_pregnancy_or_lactation": normalPregnancyOrLactation,
    "mental_wellness": mentalWellness,
    "physical_wellness": physicalWellness,
    "nutrition_wellness": nutritionWellness,
  };
}
