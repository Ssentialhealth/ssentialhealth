// To parse this JSON data, do
//
//     final childResourceModel = childResourceModelFromJson(jsonString);

import 'dart:convert';

List<ChildResourceModel> childResourceModelFromJson(String str) => List<ChildResourceModel>.from(json.decode(str).map((x) => ChildResourceModel.fromJson(x)));

String childResourceModelToJson(List<ChildResourceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildResourceModel {
  ChildResourceModel({
    this.id,
    this.name,
    this.links,
  });

  int id;
  String name;
  List<String> links;

  factory ChildResourceModel.fromJson(Map<String, dynamic> json) => ChildResourceModel(
    id: json["id"],
    name: json["name"],
    links: List<String>.from(json["links"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "links": List<dynamic>.from(links.map((x) => x)),
  };
}
