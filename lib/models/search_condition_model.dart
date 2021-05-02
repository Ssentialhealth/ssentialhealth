// To parse this JSON data, do
//
//     final searchCondition = searchConditionFromJson(jsonString);

import 'dart:convert';

List<SearchCondition> searchConditionFromJson(String str) => List<SearchCondition>.from(json.decode(str).map((x) => SearchCondition.fromJson(x)));

String searchConditionToJson(List<SearchCondition> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCondition {
  SearchCondition({
    this.id,
    this.name,
    this.overview,
    this.commonManagement,
    this.possibleCausingConditions,
  });

  int id;
  String name;
  String overview;
  List<String> commonManagement;
  List<String> possibleCausingConditions;

  factory SearchCondition.fromJson(Map<String, dynamic> json) => SearchCondition(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    commonManagement: List<String>.from(json["common_management"].map((x) => x)),
    possibleCausingConditions: List<String>.from(json["possible_causing_conditions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "common_management": List<dynamic>.from(commonManagement.map((x) => x)),
    "possible_causing_conditions": List<dynamic>.from(possibleCausingConditions.map((x) => x)),
  };
}
