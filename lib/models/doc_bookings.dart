import 'dart:convert';

import 'package:meta/meta.dart';

DocBookings docBookingsFromJson(String str) => DocBookings.fromJson(json.decode(str));

List<DocBookings> docBookingsListFromJson(String str) => List<DocBookings>.from(json.decode(str).map((x) => DocBookings.fromJson(x)));

String docBookingsListToJson(List<DocBookings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String docBookingsToJson(DocBookings data) => json.encode(data.toJson());

class DocBookings {
  DocBookings({
    @required this.id,
    @required this.appointmentDate,
    @required this.timeSlotFrom,
    @required this.timeSlotTo,
    @required this.status,
    @required this.appointmentType,
    @required this.attended,
    @required this.user,
    @required this.profile,
  });

  final int id;
  final DateTime appointmentDate;
  final String timeSlotFrom;
  final String timeSlotTo;
  final int status;
  final int appointmentType;
  final bool attended;
  final int user;
  final int profile;

  factory DocBookings.fromJson(Map<String, dynamic> json) => DocBookings(
        id: json["id"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
        timeSlotFrom: json["time_slot_from"],
        timeSlotTo: json["time_slot_to"],
        status: json["status"],
        appointmentType: json["appointment_type"],
        attended: json["attended"],
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
        "attended": attended,
        "user": user,
        "profile": profile,
      };
}
