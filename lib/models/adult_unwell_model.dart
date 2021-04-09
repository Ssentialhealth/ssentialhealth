import 'dart:convert';

List<AdultUnwellModel> adultUnwellModelFromJson(String str) => List<AdultUnwellModel>.from(json.decode(str).map((x) => AdultUnwellModel.fromJson(x)));

String adultUnwellModelToJson(List<AdultUnwellModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdultUnwellModel {
  AdultUnwellModel({
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

  factory AdultUnwellModel.fromJson(Map<String, dynamic> json) => AdultUnwellModel(
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
