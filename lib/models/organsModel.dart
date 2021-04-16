// To parse this JSON data, do
//
//     final organsModel = organsModelFromJson(jsonString);

import 'dart:convert';

List<OrgansModel> organsModelFromJson(String str) => List<OrgansModel>.from(json.decode(str).map((x) => OrgansModel.fromJson(x)));

String organsModelToJson(List<OrgansModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrgansModel {
  OrgansModel({
    this.id,
    this.possibleConditions,
    this.name,
  });

  int id;
  List<PossibleCondition> possibleConditions;
  String name;

  factory OrgansModel.fromJson(Map<String, dynamic> json) => OrgansModel(
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
