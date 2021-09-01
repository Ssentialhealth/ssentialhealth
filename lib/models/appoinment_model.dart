import 'dart:convert';

import 'package:meta/meta.dart';

List<AppointmentModel> appointmentModelListFromJson(String str) => List<AppointmentModel>.from(json.decode(str).map((x) => AppointmentModel.fromJson(x)));
AppointmentModel appointmentModelFromJson(String str) => AppointmentModel.fromJson(json.decode(str));
String appointmentModelListToJson(List<AppointmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String appointmentModelToJson(AppointmentModel data) => json.encode(data.toJson());

class AppointmentModel {
  AppointmentModel({
    @required this.id,
    @required this.appointmentDate,
    @required this.timeSlotFrom,
    @required this.timeSlotTo,
    @required this.status,
    @required this.appointmentType,
    @required this.user,
    @required this.profile,
  });

  final int id;
  final DateTime appointmentDate;
  final int appointmentType;
  final String timeSlotFrom;
  final String timeSlotTo;
  final int status;
  final int user;
  final int profile;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
        id: json["id"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
        timeSlotFrom: json["time_slot_from"],
        timeSlotTo: json["time_slot_to"],
        status: json["status"],
        appointmentType: json["appointment_type"],
        user: json["user"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appointment_date":
            "${appointmentDate.year.toString().padLeft(4, '0')}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}",
        "time_slot_from": timeSlotFrom,
        "time_slot_to": timeSlotTo,
        "status": status,
        "appointment_type": appointmentType,
        "user": user,
        "profile": profile,
      };
}
