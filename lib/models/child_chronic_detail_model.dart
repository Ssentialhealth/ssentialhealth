// To parse this JSON data, do
//
//     final congenitalDetailModel = congenitalDetailModelFromJson(jsonString);

import 'dart:convert';

CongenitalDetailModel congenitalDetailModelFromJson(String str) => CongenitalDetailModel.fromJson(json.decode(str));

String congenitalDetailModelToJson(CongenitalDetailModel data) => json.encode(data.toJson());

class CongenitalDetailModel {
  CongenitalDetailModel({
    this.id,
    this.name,
    this.overview,
    this.mainCauses,
    this.contributoryCauses,
    this.signsAndSymptoms,
    this.diagnosis,
    this.treatmentAndManagement,
  });

  int id;
  String name;
  String overview;
  List<String> mainCauses;
  List<String> contributoryCauses;
  List<String> signsAndSymptoms;
  String diagnosis;
  List<String> treatmentAndManagement;

  factory CongenitalDetailModel.fromJson(Map<String, dynamic> json) => CongenitalDetailModel(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    mainCauses: List<String>.from(json["main_causes"].map((x) => x)),
    contributoryCauses: List<String>.from(json["contributory_causes"].map((x) => x)),
    signsAndSymptoms: List<String>.from(json["signs_and_symptoms"].map((x) => x)),
    diagnosis: json["diagnosis"],
    treatmentAndManagement: List<String>.from(json["treatment_and_management"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "main_causes": List<dynamic>.from(mainCauses.map((x) => x)),
    "contributory_causes": List<dynamic>.from(contributoryCauses.map((x) => x)),
    "signs_and_symptoms": List<dynamic>.from(signsAndSymptoms.map((x) => x)),
    "diagnosis": diagnosis,
    "treatment_and_management": List<dynamic>.from(treatmentAndManagement.map((x) => x)),
  };
}
