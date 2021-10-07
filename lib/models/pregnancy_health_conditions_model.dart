import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/pregnancy_lactation_service.dart';

List<PregnancyHealthConditionsModel> pregnancyHealthConditionsModelFromJson(String str) =>
    List<PregnancyHealthConditionsModel>.from(json.decode(str).map((x) => PregnancyHealthConditionsModel.fromJson(x)));

String pregnancyHealthConditionsModelToJson(List<PregnancyHealthConditionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final pregnancyHealthConditionsModelProvider = FutureProvider.autoDispose<List<PregnancyHealthConditionsModel>>((ref) async {
  final pregService = ref.watch(pregServiceProvider);
  final data = await pregService.getPregnancyHealthConditions();
  return data;
});

class PregnancyHealthConditionsModel {
  PregnancyHealthConditionsModel({
    @required this.id,
    @required this.name,
    @required this.overview,
    @required this.symptomsOverview,
    @required this.investigation,
    @required this.treatment,
    @required this.medications,
    @required this.prevention,
    @required this.complications,
    @required this.otherPossibleConditions,
    @required this.symptoms,
  });

  final int id;
  final String name;
  final String overview;
  final String symptomsOverview;
  final String investigation;
  final String treatment;
  final String medications;
  final String prevention;
  final String complications;
  final String otherPossibleConditions;
  final int symptoms;

  factory PregnancyHealthConditionsModel.fromJson(Map<String, dynamic> json) => PregnancyHealthConditionsModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        symptomsOverview: json["symptoms_overview"],
        investigation: json["investigation"],
        treatment: json["treatment"],
        medications: json["medications"],
        prevention: json["prevention"],
        complications: json["complications"],
        otherPossibleConditions: json["other_possible_conditions"],
        symptoms: json["symptoms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "symptoms_overview": symptomsOverview,
        "investigation": investigation,
        "treatment": treatment,
        "medications": medications,
        "prevention": prevention,
        "complications": complications,
        "other_possible_conditions": otherPossibleConditions,
        "symptoms": symptoms,
      };
}
