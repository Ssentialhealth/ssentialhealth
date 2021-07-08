// To parse this JSON data, do
//
//     final symptomDetail = symptomDetailFromJson(jsonString);

import 'dart:convert';

SymptomDetail symptomDetailFromJson(String str) => SymptomDetail.fromJson(json.decode(str));

String symptomDetailToJson(SymptomDetail data) => json.encode(data.toJson());

class SymptomDetail {
  SymptomDetail({
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

  factory SymptomDetail.fromJson(Map<String, dynamic> json) => SymptomDetail(
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
