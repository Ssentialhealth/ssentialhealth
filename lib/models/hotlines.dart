import 'dart:convert';

import 'package:equatable/equatable.dart';

Hotlines hotlinesFromJson(String str) => Hotlines.fromJson(json.decode(str));

String hotlinesToJson(Hotlines data) => json.encode(data.toJson());

class Hotlines extends Equatable {
  Hotlines({
    this.ambulanceAndMedical,
    this.healthInsurer,
    this.accidentAndRescue,
    this.childAbuse,
    this.fireAndDisaster,
    this.policeAndSecurity,
    this.sexualAndGenderViolence,
    this.sexualAndReproductive,
    this.suicideAndMental,
  });

  List<AccidentAndRescue> ambulanceAndMedical;
  List<AccidentAndRescue> healthInsurer;
  List<AccidentAndRescue> accidentAndRescue;
  List<AccidentAndRescue> childAbuse;
  List<AccidentAndRescue> fireAndDisaster;
  List<AccidentAndRescue> policeAndSecurity;
  List<AccidentAndRescue> sexualAndGenderViolence;
  List<AccidentAndRescue> sexualAndReproductive;
  List<AccidentAndRescue> suicideAndMental;

  factory Hotlines.fromJson(Map<String, dynamic> json) => Hotlines(
    ambulanceAndMedical: List<AccidentAndRescue>.from(json["ambulance_and_medical"].map((x) => AccidentAndRescue.fromJson(x))),
    healthInsurer: List<AccidentAndRescue>.from(json["health_insurer"].map((x) => AccidentAndRescue.fromJson(x))),
    accidentAndRescue: List<AccidentAndRescue>.from(json["accident_and_rescue"].map((x) => AccidentAndRescue.fromJson(x))),
    childAbuse: List<AccidentAndRescue>.from(json["children_abuse"].map((x) => AccidentAndRescue.fromJson(x))),
    fireAndDisaster: List<AccidentAndRescue>.from(json["fire_and_disaster"].map((x) => AccidentAndRescue.fromJson(x))),
    policeAndSecurity: List<AccidentAndRescue>.from(json["police_and_security"].map((x) => AccidentAndRescue.fromJson(x))),
    sexualAndGenderViolence: List<AccidentAndRescue>.from(json["sexual_and_gender_violence"].map((x) => AccidentAndRescue.fromJson(x))),
    sexualAndReproductive: List<AccidentAndRescue>.from(json["sexual_and_reproductive_health"].map((x) => AccidentAndRescue.fromJson(x))),
    suicideAndMental: List<AccidentAndRescue>.from(json["suicide_and_mental_health"].map((x) => AccidentAndRescue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ambulance_and_medical": List<dynamic>.from(ambulanceAndMedical.map((x) => x.toJson())),
    "health_insurer": List<dynamic>.from(healthInsurer.map((x) => x.toJson())),
    "accident_and_rescue": List<dynamic>.from(accidentAndRescue.map((x) => x.toJson())),
    "children_abuse": List<dynamic>.from(childAbuse.map((x) => x.toJson())),
    "fire_and_disaster": List<dynamic>.from(fireAndDisaster.map((x) => x.toJson())),
    "police_and_security": List<dynamic>.from(policeAndSecurity.map((x) => x.toJson())),
    "sexual_and_gender_violence": List<dynamic>.from(sexualAndGenderViolence.map((x) => x.toJson())),
    "sexual_and_reproductive_health": List<dynamic>.from(sexualAndReproductive.map((x) => x.toJson())),
    "suicide_and_mental_health": List<dynamic>.from(suicideAndMental.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object> get props => [
    ambulanceAndMedical,
    healthInsurer,
    accidentAndRescue,
    childAbuse,
    fireAndDisaster,
    policeAndSecurity,
    sexualAndGenderViolence,
    sexualAndReproductive,
    suicideAndMental,
  ];
}

class AccidentAndRescue extends Equatable{
  AccidentAndRescue({
    this.id,
    this.name,
    this.location,
    this.phoneNumbers,
    this.country,
  });

  int id;
  String name;
  String location;
  List<String> phoneNumbers;
  String country;

  factory AccidentAndRescue.fromJson(Map<String, dynamic> json) => AccidentAndRescue(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    country: json["country"],
    phoneNumbers: List<String>.from(json["phone_numbers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "country": country,
    "phone_numbers": List<dynamic>.from(phoneNumbers.map((x) => x)),
  };

  @override
  // TODO: implement props
  List<Object> get props => [id,name,location,phoneNumbers,country];
}
