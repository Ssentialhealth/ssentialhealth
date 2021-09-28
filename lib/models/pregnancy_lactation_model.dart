// To parse this JSON data, do
//
//     final pregnancyLactationModel = pregnancyLactationModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

PregnancyLactationModel pregnancyLactationModelFromJson(String str) => PregnancyLactationModel.fromJson(json.decode(str));

String pregnancyLactationModelToJson(PregnancyLactationModel data) => json.encode(data.toJson());

class PregnancyLactationModel extends Equatable {
  PregnancyLactationModel({
    @required this.id,
    @required this.menstrualCycleOrPeriodCycle,
    @required this.normalPregnancyOrLactation,
    @required this.unwellInPregnancyOrLactation,
    @required this.nutritionOrPhysicalAndWellness,
    @required this.pregnancyOrLactationResources,
  });

  final int id;
  final String menstrualCycleOrPeriodCycle;
  final String normalPregnancyOrLactation;
  final String unwellInPregnancyOrLactation;
  final String nutritionOrPhysicalAndWellness;
  final String pregnancyOrLactationResources;

  factory PregnancyLactationModel.fromJson(Map<String, dynamic> json) => PregnancyLactationModel(
        id: json["id"],
        menstrualCycleOrPeriodCycle: json["menstrual_cycle_or_period_cycle"],
        normalPregnancyOrLactation: json["normal_pregnancy_or_lactation"],
        unwellInPregnancyOrLactation: json["unwell_in_pregnancy_or_lactation"],
        nutritionOrPhysicalAndWellness: json["nutrition_or_physical_and_wellness"],
        pregnancyOrLactationResources: json["pregnancy_or_lactation_resources"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menstrual_cycle_or_period_cycle": menstrualCycleOrPeriodCycle,
        "normal_pregnancy_or_lactation": normalPregnancyOrLactation,
        "unwell_in_pregnancy_or_lactation": unwellInPregnancyOrLactation,
        "nutrition_or_physical_and_wellness": nutritionOrPhysicalAndWellness,
        "pregnancy_or_lactation_resources": pregnancyOrLactationResources,
      };

  @override
  List<Object> get props => [
        id,
        menstrualCycleOrPeriodCycle,
        normalPregnancyOrLactation,
        unwellInPregnancyOrLactation,
        nutritionOrPhysicalAndWellness,
        pregnancyOrLactationResources,
      ];
}
