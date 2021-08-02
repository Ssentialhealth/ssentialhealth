// To parse this JSON data, do
//
//     final allScheduleModel = allScheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<AllScheduleModel> allScheduleModelFromJson(String str) => List<AllScheduleModel>.from(json.decode(str).map((x) => AllScheduleModel.fromJson(x)));

String allScheduleModelToJson(List<AllScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

AllScheduleModel oneScheduleModelFromJson(String str) => AllScheduleModel.fromJson(json.decode(str));

String oneScheduleModelToJson(AllScheduleModel data) => json.encode(data.toJson());

class AllScheduleModel {
  AllScheduleModel({
    @required this.id,
    @required this.schedules,
    @required this.childName,
    @required this.childDob,
    @required this.user,
  });

  final int id;
  final List<Schedule> schedules;
  final String childName;
  final DateTime childDob;
  final int user;

  factory AllScheduleModel.fromJson(Map<String, dynamic> json) => AllScheduleModel(
        id: json["id"],
        schedules: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
        childName: json["child_name"],
        childDob: DateTime.parse(json["child_dob"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
        "child_name": childName,
        "child_dob": "${childDob.year.toString().padLeft(4, '0')}-${childDob.month.toString().padLeft(2, '0')}-${childDob.day.toString().padLeft(2, '0')}",
        "user": user,
      };
}

class Schedule {
  Schedule({
    @required this.id,
    @required this.vaccines,
    @required this.age,
    @required this.dueDate,
  });

  final int id;
  final List<Vaccine> vaccines;
  final String age;
  final dynamic dueDate;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        vaccines: List<Vaccine>.from(json["vaccines"].map((x) => Vaccine.fromJson(x))),
        age: json["age"],
        dueDate: json["due_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vaccines": List<dynamic>.from(vaccines.map((x) => x.toJson())),
        "age": age,
        "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
      };
}

class Vaccine {
  Vaccine({
    @required this.id,
    @required this.vaccineName,
    @required this.received,
    @required this.dateReceived,
    @required this.schedule,
  });

  final int id;
  final String vaccineName;
  final bool received;
  final dynamic dateReceived;
  final int schedule;

  factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
        id: json["id"],
        vaccineName: json["vaccine_name"],
        received: json["received"],
        dateReceived: json["date_received"],
        schedule: json["schedule"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vaccine_name": vaccineName,
        "received": received,
        "date_received": dateReceived,
        "schedule": schedule,
      };
}
