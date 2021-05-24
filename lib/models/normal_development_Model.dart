// To parse this JSON data, do
//
//     final normalDevelopmentModel = normalDevelopmentModelFromJson(jsonString);

import 'dart:convert';

NormalDevelopmentModel normalDevelopmentModelFromJson(String str) => NormalDevelopmentModel.fromJson(json.decode(str));

String normalDevelopmentModelToJson(NormalDevelopmentModel data) => json.encode(data.toJson());

class NormalDevelopmentModel {
  NormalDevelopmentModel({
    this.overview,
    this.milestones,
  });

  Overview overview;
  List<Milestone> milestones;

  factory NormalDevelopmentModel.fromJson(Map<String, dynamic> json) => NormalDevelopmentModel(
    overview: Overview.fromJson(json["overview"]),
    milestones: List<Milestone>.from(json["milestones"].map((x) => Milestone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overview": overview.toJson(),
    "milestones": List<dynamic>.from(milestones.map((x) => x.toJson())),
  };
}

class Milestone {
  Milestone({
    this.id,
    this.age,
    this.expectedMilestones,
  });

  int id;
  String age;
  List<String> expectedMilestones;

  factory Milestone.fromJson(Map<String, dynamic> json) => Milestone(
    id: json["id"],
    age: json["age"],
    expectedMilestones: List<String>.from(json["expected_milestones"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "expected_milestones": List<dynamic>.from(expectedMilestones.map((x) => x)),
  };
}

class Overview {
  Overview({
    this.id,
    this.overview,
  });

  int id;
  String overview;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    id: json["id"],
    overview: json["overview"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
  };
}
