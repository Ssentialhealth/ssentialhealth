// To parse this JSON data, do
//
//     final scheduleDetail = scheduleDetailFromJson(jsonString);

import 'dart:convert';

List<ScheduleDetail> scheduleDetailFromJson(String str) => List<ScheduleDetail>.from(json.decode(str).map((x) => ScheduleDetail.fromJson(x)));

String scheduleDetailToJson(List<ScheduleDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleDetail {
	int id;
  List<Schedules> schedules;
  String childName;
  String childDob;
  int user;

  ScheduleDetail({this.id, this.schedules, this.childName, this.childDob, this.user});

  ScheduleDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['schedules'] != null) {
      schedules = new List<Schedules>();
      json['schedules'].forEach((v) {
        schedules.add(new Schedules.fromJson(v));
      });
    }
    childName = json['child_name'];
    childDob = json['child_dob'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.schedules != null) {
      data['schedules'] = this.schedules.map((v) => v.toJson()).toList();
    }
    data['child_name'] = this.childName;
    data['child_dob'] = this.childDob;
    data['user'] = this.user;
    return data;
  }
}

class Schedules {
  int id;
  List<Vaccines> vaccines;
  String age;
  String dueDate;

  Schedules({this.id, this.vaccines, this.age, this.dueDate});

  Schedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['vaccines'] != null) {
      vaccines = new List<Vaccines>();
      json['vaccines'].forEach((v) {
        vaccines.add(new Vaccines.fromJson(v));
      });
    }
    age = json['age'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.vaccines != null) {
      data['vaccines'] = this.vaccines.map((v) => v.toJson()).toList();
    }
    data['age'] = this.age;
    data['due_date'] = this.dueDate;
    return data;
  }
}

class Vaccines {
  int id;
  String vaccineName;
  bool received;
  String dateReceived;
  int schedule;

  Vaccines({this.id, this.vaccineName, this.received, this.dateReceived, this.schedule});

  Vaccines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vaccineName = json['vaccine_name'];
    received = json['received'];
    dateReceived = json['date_received'];
    schedule = json['schedule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vaccine_name'] = this.vaccineName;
    data['received'] = this.received;
    data['date_received'] = this.dateReceived;
    data['schedule'] = this.schedule;
    return data;
  }
}
