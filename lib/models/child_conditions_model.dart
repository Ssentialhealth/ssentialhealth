// To parse this JSON data, do
//
//     final childConditionsModel = childConditionsModelFromJson(jsonString);

import 'dart:convert';

List<ChildConditionsModel> childConditionsModelFromJson(String str) => List<ChildConditionsModel>.from(json.decode(str).map((x) => ChildConditionsModel.fromJson(x)));

String childConditionsModelToJson(List<ChildConditionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildConditionsModel {
  ChildConditionsModel({
    this.id,
    this.otherPossibleConditions,
    this.symptoms,
    this.medication,
    this.name,
    this.overview,
    this.symptomsOverview,
    this.investigation,
    this.treatment,
    this.prevention,
    this.complications,
  });

  int id;
  List<dynamic> otherPossibleConditions;
  List<Symptom> symptoms;
  Medication medication;
  String name;
  String overview;
  String symptomsOverview;
  String investigation;
  String treatment;
  List<String> prevention;
  List<String> complications;

  factory ChildConditionsModel.fromJson(Map<String, dynamic> json) => ChildConditionsModel(
    id: json["id"],
    otherPossibleConditions: List<dynamic>.from(json["other_possible_conditions"].map((x) => x)),
    symptoms: List<Symptom>.from(json["symptoms"].map((x) => Symptom.fromJson(x))),
    medication: Medication.fromJson(json["medication"]),
    name: json["name"],
    overview: json["overview"],
    symptomsOverview: json["symptoms_overview"],
    investigation: json["investigation"],
    treatment: json["treatment"],
    prevention: List<String>.from(json["prevention"].map((x) => x)),
    complications: List<String>.from(json["complications"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "other_possible_conditions": List<dynamic>.from(otherPossibleConditions.map((x) => x)),
    "symptoms": List<dynamic>.from(symptoms.map((x) => x.toJson())),
    "medication": medication.toJson(),
    "name": name,
    "overview": overview,
    "symptoms_overview": symptomsOverview,
    "investigation": investigation,
    "treatment": treatment,
    "prevention": List<dynamic>.from(prevention.map((x) => x)),
    "complications": List<dynamic>.from(complications.map((x) => x)),
  };
}

class Medication {
  Medication({
    this.id,
    this.upto12Months,
    this.oneToTwoYears,
    this.twoToSixYears,
    this.above6Years,
  });

  int id;
  List<String> upto12Months;
  List<String> oneToTwoYears;
  List<String> twoToSixYears;
  List<String> above6Years;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
    id: json["id"],
    upto12Months: List<String>.from(json["upto_12_months"].map((x) => x)),
    oneToTwoYears: List<String>.from(json["one_to_two_years"].map((x) => x)),
    twoToSixYears: List<String>.from(json["two_to_six_years"].map((x) => x)),
    above6Years: List<String>.from(json["above_6_years"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "upto_12_months": List<dynamic>.from(upto12Months.map((x) => x)),
    "one_to_two_years": List<dynamic>.from(oneToTwoYears.map((x) => x)),
    "two_to_six_years": List<dynamic>.from(twoToSixYears.map((x) => x)),
    "above_6_years": List<dynamic>.from(above6Years.map((x) => x)),
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
