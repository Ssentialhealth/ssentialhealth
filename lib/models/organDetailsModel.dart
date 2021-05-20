// To parse this JSON data, do
//
//     final organDetailsModel = organDetailsModelFromJson(jsonString);

import 'dart:convert';

OrganDetailsModel organDetailsModelFromJson(String str) => OrganDetailsModel.fromJson(json.decode(str));

String organDetailsModelToJson(OrganDetailsModel data) => json.encode(data.toJson());

class OrganDetailsModel {
  OrganDetailsModel({
    this.id,
    this.possibleConditions,
    this.name,
  });

  int id;
  List<PossibleCondition> possibleConditions;
  String name;

  factory OrganDetailsModel.fromJson(Map<String, dynamic> json) => OrganDetailsModel(
    id: json["id"],
    possibleConditions: List<PossibleCondition>.from(json["possible_conditions"].map((x) => PossibleCondition.fromJson(x))),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "possible_conditions": List<dynamic>.from(possibleConditions.map((x) => x.toJson())),
    "name": name,
  };
}

class PossibleCondition {
  PossibleCondition({
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
  List<Condition> otherPossibleConditions;
  List<Symptom> symptoms;
  String name;
  String overview;
  String symptomsOverview;
  String investigation;
  String treatment;
  List<String> medications;
  List<String> prevention;
  List<String> complications;

  factory PossibleCondition.fromJson(Map<String, dynamic> json) => PossibleCondition(
    id: json["id"],
    otherPossibleConditions: List<Condition>.from(json["other_possible_conditions"].map((x) => Condition.fromJson(x))),
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
    "other_possible_conditions": List<dynamic>.from(otherPossibleConditions.map((x) => x.toJson())),
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

class Condition {
  Condition({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
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
  List<Condition> healthConditions;
  String name;
  String overview;
  List<String> commonManagement;

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
    id: json["id"],
    healthConditions: List<Condition>.from(json["health_conditions"].map((x) => Condition.fromJson(x))),
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
