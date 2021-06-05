// To parse this JSON data, do
//
//     final delayedMilestoneModel = delayedMilestoneModelFromJson(jsonString);

import 'dart:convert';

DelayedMilestoneModel delayedMilestoneModelFromJson(String str) => DelayedMilestoneModel.fromJson(json.decode(str));

String delayedMilestoneModelToJson(DelayedMilestoneModel data) => json.encode(data.toJson());

class DelayedMilestoneModel {
  DelayedMilestoneModel({
    this.overview,
    this.data,
  });

  Overview overview;
  List<Datum> data;

  factory DelayedMilestoneModel.fromJson(Map<String, dynamic> json) => DelayedMilestoneModel(
    overview: Overview.fromJson(json["overview"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overview": overview.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.overview,
    this.possibleCauses,
  });

  int id;
  String name;
  String overview;
  List<String> possibleCauses;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    possibleCauses: List<String>.from(json["possible_causes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "possible_causes": List<dynamic>.from(possibleCauses.map((x) => x)),
  };
}

class Overview {
  Overview({
    this.id,
    this.overview,
    this.causes,
  });

  int id;
  String overview;
  List<String> causes;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    id: json["id"],
    overview: json["overview"],
    causes: List<String>.from(json["causes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
    "causes": List<dynamic>.from(causes.map((x) => x)),
  };
}
