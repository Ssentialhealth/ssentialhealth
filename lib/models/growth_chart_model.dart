// To parse this JSON data, do
//
//     final growthChartModel = growthChartModelFromJson(jsonString);

import 'dart:convert';

GrowthChartModel growthChartModelFromJson(String str) => GrowthChartModel.fromJson(json.decode(str));

String growthChartModelToJson(GrowthChartModel data) => json.encode(data.toJson());

class GrowthChartModel {
  GrowthChartModel({
    this.overview,
    this.data,
  });

  Overview overview;
  List<Datum> data;

  factory GrowthChartModel.fromJson(Map<String, dynamic> json) => GrowthChartModel(
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
    this.links,
  });

  int id;
  String name;
  List<String> links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Overview {
  Overview({
    this.overview,
  });

  String overview;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    overview: json["overview"],
  );

  Map<String, dynamic> toJson() => {
    "overview": overview,
  };
}
