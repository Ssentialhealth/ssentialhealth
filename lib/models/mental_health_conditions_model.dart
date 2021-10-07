// To parse this JSON data, do
//
//     final mentalHealthConditionsModel = mentalHealthConditionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_riverpod/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/mental_health_conditions_service.dart';

List<MentalHealthConditionsModel> mentalHealthConditionsModelFromJson(String str) =>
    List<MentalHealthConditionsModel>.from(json.decode(str).map((x) => MentalHealthConditionsModel.fromJson(x)));
String mentalHealthConditionsModelToJson(List<MentalHealthConditionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final mentalHealthConditionsModelProvider = FutureProvider.autoDispose<List<MentalHealthConditionsModel>>((ref) async {
  final mentalHealthConditionsService = ref.watch(mentalHealthConditionsServiceProvider);
  final data = mentalHealthConditionsService.fetchMentalHealthConditions();
  return data;
});

class MentalHealthConditionsModel {
  MentalHealthConditionsModel({
    @required this.id,
    @required this.condition,
    @required this.overview,
    @required this.causes,
    @required this.signsAndSymptoms,
  });

  final int id;
  final String condition;
  final String overview;
  final String causes;
  final String signsAndSymptoms;

  factory MentalHealthConditionsModel.fromJson(Map<String, dynamic> json) => MentalHealthConditionsModel(
        id: json["id"],
        condition: json["condition"],
        overview: json["overview"],
        causes: json["causes"],
        signsAndSymptoms: json["signs_and_symptoms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "condition": condition,
        "overview": overview,
        "causes": causes,
        "signs_and_symptoms": signsAndSymptoms,
      };
}
