// To parse this JSON data, do
//
//     final searchCondition = searchConditionFromJson(jsonString);

import 'dart:convert';

List<SearchCondition> searchConditionFromJson(String str) => List<SearchCondition>.from(json.decode(str).map((x) => SearchCondition.fromJson(x)));

String searchConditionToJson(List<SearchCondition> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCondition {
  SearchCondition({
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

  factory SearchCondition.fromJson(Map<String, dynamic> json) => SearchCondition(
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
