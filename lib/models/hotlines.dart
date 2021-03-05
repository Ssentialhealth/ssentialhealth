import 'dart:convert';

import 'package:equatable/equatable.dart';

Hotlines hotlinesFromJson(String str) => Hotlines.fromJson(json.decode(str));

String hotlinesToJson(Hotlines data) => json.encode(data.toJson());

class Hotlines extends Equatable {
  Hotlines({
    this.ambulanceAndMedical,
    this.healthInsurer,
  });

  List<AccidentAndRescue> ambulanceAndMedical;
  List<AccidentAndRescue> healthInsurer;

  factory Hotlines.fromJson(Map<String, dynamic> json) => Hotlines(
    ambulanceAndMedical: List<AccidentAndRescue>.from(json["ambulance_and_medical"].map((x) => AccidentAndRescue.fromJson(x))),
    healthInsurer: List<AccidentAndRescue>.from(json["health_insurer"].map((x) => AccidentAndRescue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ambulance_and_medical": List<dynamic>.from(ambulanceAndMedical.map((x) => x.toJson())),
    "health_insurer": List<dynamic>.from(healthInsurer.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object> get props => [ambulanceAndMedical,healthInsurer];
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
