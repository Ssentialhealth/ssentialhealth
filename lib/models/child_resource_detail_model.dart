// To parse this JSON data, do
//
//     final childResourceDetailModel = childResourceDetailModelFromJson(jsonString);

import 'dart:convert';

ChildResourceDetailModel childResourceDetailModelFromJson(String str) => ChildResourceDetailModel.fromJson(json.decode(str));

String childResourceDetailModelToJson(ChildResourceDetailModel data) => json.encode(data.toJson());

class ChildResourceDetailModel {
  ChildResourceDetailModel({
    this.id,
    this.name,
    this.links,
  });

  int id;
  String name;
  List<String> links;

  factory ChildResourceDetailModel.fromJson(Map<String, dynamic> json) => ChildResourceDetailModel(
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
