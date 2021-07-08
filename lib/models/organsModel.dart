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
  List<dynamic> possibleConditions;
  String name;

  factory OrgansModel.fromJson(Map<String, dynamic> json) => OrgansModel(
    id: json["id"],
    possibleConditions: List<dynamic>.from(json["possible_conditions"].map((x) => x)),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "possible_conditions": List<dynamic>.from(possibleConditions.map((x) => x)),
    "name": name,
  };
}
