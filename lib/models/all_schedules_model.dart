// To parse this JSON data, do
//
//     final allScheduleModel = allScheduleModelFromJson(jsonString);

import 'dart:convert';

List<AllScheduleModel> allScheduleModelFromJson(String str) => List<AllScheduleModel>.from(json.decode(str).map((x) => AllScheduleModel.fromJson(x)));

String allScheduleModelToJson(List<AllScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllScheduleModel {
  AllScheduleModel({
    this.id,
    this.schedules,
    this.childName,
    this.childDob,
    this.user,
  });

  int id;
  List<Schedule> schedules;
  String childName;
  DateTime childDob;
  int user;

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
    this.id,
    this.age,
    this.vaccines,
    this.dueDate,
    this.received,
    this.dateReceived,
  });

  int id;
  String age;
  List<String> vaccines;
  DateTime dueDate;
  bool received;
  dynamic dateReceived;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["id"],
    age: json["age"],
    vaccines: List<String>.from(json["vaccines"].map((x) => x)),
    dueDate: DateTime.parse(json["due_date"]),
    received: json["received"],
    dateReceived: json["date_received"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "vaccines": List<dynamic>.from(vaccines.map((x) => x)),
    "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
    "received": received,
    "date_received": dateReceived,
  };
}
