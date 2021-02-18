import 'dart:convert';

Hotlines hotlinesFromJson(String str) => Hotlines.fromJson(json.decode(str));

String hotlinesToJson(Hotlines data) => json.encode(data.toJson());

class Hotlines {
  Hotlines({
    this.accidentAndRescue,
    this.ambulanceAndMedical,
    this.childrenAbuse,
    this.fireAndDisaster,
    this.healthInsurer,
    this.policeAndSecurity,
    this.sexualAndGenderViolence,
    this.sexualAndReproductiveHealth,
    this.suicideAndMentalHealth,
  });

  List<AccidentAndRescue> accidentAndRescue;
  List<AccidentAndRescue> ambulanceAndMedical;
  List<AccidentAndRescue> childrenAbuse;
  List<AccidentAndRescue> fireAndDisaster;
  List<AccidentAndRescue> healthInsurer;
  List<AccidentAndRescue> policeAndSecurity;
  List<AccidentAndRescue> sexualAndGenderViolence;
  List<AccidentAndRescue> sexualAndReproductiveHealth;
  List<AccidentAndRescue> suicideAndMentalHealth;

  factory Hotlines.fromJson(Map<String, dynamic> json) => Hotlines(
    accidentAndRescue: List<AccidentAndRescue>.from(json["accident_and_rescue"].map((x) => AccidentAndRescue.fromJson(x))),
    ambulanceAndMedical: List<AccidentAndRescue>.from(json["ambulance_and_medical"].map((x) => AccidentAndRescue.fromJson(x))),
    childrenAbuse: List<AccidentAndRescue>.from(json["children_abuse"].map((x) => AccidentAndRescue.fromJson(x))),
    fireAndDisaster: List<AccidentAndRescue>.from(json["fire_and_disaster"].map((x) => AccidentAndRescue.fromJson(x))),
    healthInsurer: List<AccidentAndRescue>.from(json["health_insurer"].map((x) => AccidentAndRescue.fromJson(x))),
    policeAndSecurity: List<AccidentAndRescue>.from(json["police_and_security"].map((x) => AccidentAndRescue.fromJson(x))),
    sexualAndGenderViolence: List<AccidentAndRescue>.from(json["sexual_and_gender_violence"].map((x) => AccidentAndRescue.fromJson(x))),
    sexualAndReproductiveHealth: List<AccidentAndRescue>.from(json["sexual_and_reproductive_health"].map((x) => AccidentAndRescue.fromJson(x))),
    suicideAndMentalHealth: List<AccidentAndRescue>.from(json["suicide_and_mental_health"].map((x) => AccidentAndRescue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "accident_and_rescue": List<dynamic>.from(accidentAndRescue.map((x) => x.toJson())),
    "ambulance_and_medical": List<dynamic>.from(ambulanceAndMedical.map((x) => x.toJson())),
    "children_abuse": List<dynamic>.from(childrenAbuse.map((x) => x.toJson())),
    "fire_and_disaster": List<dynamic>.from(fireAndDisaster.map((x) => x.toJson())),
    "health_insurer": List<dynamic>.from(healthInsurer.map((x) => x.toJson())),
    "police_and_security": List<dynamic>.from(policeAndSecurity.map((x) => x.toJson())),
    "sexual_and_gender_violence": List<dynamic>.from(sexualAndGenderViolence.map((x) => x.toJson())),
    "sexual_and_reproductive_health": List<dynamic>.from(sexualAndReproductiveHealth.map((x) => x.toJson())),
    "suicide_and_mental_health": List<dynamic>.from(suicideAndMentalHealth.map((x) => x.toJson())),
  };
}

class AccidentAndRescue {
  AccidentAndRescue({
    this.id,
    this.name,
    this.location,
    this.phoneNumber,
  });

  int id;
  String name;
  String location;
  String phoneNumber;

  factory AccidentAndRescue.fromJson(Map<String, dynamic> json) => AccidentAndRescue(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "phone_number": phoneNumber,
  };
}
