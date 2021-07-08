// To parse this JSON data, do
//
//     final adultUnwellModel = adultUnwellModelFromJson(jsonString);

import 'dart:convert';

List<AdultUnwellModel> adultUnwellModelFromJson(String str) => List<AdultUnwellModel>.from(json.decode(str).map((x) => AdultUnwellModel.fromJson(x)));

String adultUnwellModelToJson(List<AdultUnwellModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdultUnwellModel {
  AdultUnwellModel({
    this.id,
    this.otherPossibleConditions,
    this.symptoms,
    this.name,
    this.overview,
    this.symptomsOverview,
    this.investigation,
    this.treatment,
    this.medications,
    this.prevention,
    this.complications,
  });

  int id;
  List<dynamic> otherPossibleConditions;
  List<Symptom> symptoms;
  String name;
  String overview;
  String symptomsOverview;
  String investigation;
  String treatment;
  List<String> medications;
  List<String> prevention;
  List<String> complications;

  factory AdultUnwellModel.fromJson(Map<String, dynamic> json) => AdultUnwellModel(
    id: json["id"],
    otherPossibleConditions: List<dynamic>.from(json["other_possible_conditions"].map((x) => x)),
    symptoms: List<Symptom>.from(json["symptoms"].map((x) => Symptom.fromJson(x))),
    name: json["name"],
    overview: json["overview"],
    symptomsOverview: json["symptoms_overview"],
    investigation: json["investigation"],
    treatment: json["treatment"],
    medications: List<String>.from(json["medications"].map((x) => x)),
    prevention: List<String>.from(json["prevention"].map((x) => x)),
    complications: List<String>.from(json["complications"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "other_possible_conditions": List<dynamic>.from(otherPossibleConditions.map((x) => x)),
    "symptoms": List<dynamic>.from(symptoms.map((x) => x.toJson())),
    "name": name,
    "overview": overview,
    "symptoms_overview": symptomsOverview,
    "investigation": investigation,
    "treatment": treatment,
    "medications": List<dynamic>.from(medications.map((x) => x)),
    "prevention": List<dynamic>.from(prevention.map((x) => x)),
    "complications": List<dynamic>.from(complications.map((x) => x)),
  };
}

class Symptom {
  Symptom({
    this.id,
    this.healthConditions,
    this.name,
    this.overview,
    this.commonManagement,
  });

  int id;
  List<HealthCondition> healthConditions;
  String name;
  String overview;
  List<String> commonManagement;

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
    id: json["id"],
    healthConditions: List<HealthCondition>.from(json["health_conditions"].map((x) => HealthCondition.fromJson(x))),
    name: json["name"],
    overview: json["overview"],
    commonManagement: List<String>.from(json["common_management"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "health_conditions": List<dynamic>.from(healthConditions.map((x) => x.toJson())),
    "name": name,
    "overview": overview,
    "common_management": List<dynamic>.from(commonManagement.map((x) => x)),
  };
}

class HealthCondition {
  HealthCondition({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory HealthCondition.fromJson(Map<String, dynamic> json) => HealthCondition(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
