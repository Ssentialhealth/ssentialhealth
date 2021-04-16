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

  factory PossibleCondition.fromJson(Map<String, dynamic> json) => PossibleCondition(
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
