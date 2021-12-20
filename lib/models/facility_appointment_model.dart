import 'dart:convert';

import 'package:meta/meta.dart';

List<FacilityAppointmentModel> facilityAppointmentModelListFromJson(String str) =>
    List<FacilityAppointmentModel>.from(json.decode(str).map((x) => FacilityAppointmentModel.fromJson(x)));

FacilityAppointmentModel facilityAppointmentModelFromJson(String str) => FacilityAppointmentModel.fromJson(json.decode(str));

String facilityAppointmentModelListToJson(List<FacilityAppointmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String facilityAppointmentModelToJson(FacilityAppointmentModel data) => json.encode(data.toJson());

class FacilityAppointmentModel {
  FacilityAppointmentModel({
    this.id,
    @required this.appointmentDate,
    @required this.timeSlotFrom,
    @required this.timeSlotTo,
    @required this.status,
    @required this.appointmentType,
    @required this.user,
    @required this.facility,
  });

  final int id;
  final DateTime appointmentDate;
  final int appointmentType;
  final String timeSlotFrom;
  final String timeSlotTo;
  final int status;
  final int user;
  final int facility;

  factory FacilityAppointmentModel.fromJson(Map<String, dynamic> json) => FacilityAppointmentModel(
        id: json["id"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
        timeSlotFrom: json["time_slot_from"],
        timeSlotTo: json["time_slot_to"],
        status: json["status"],
        appointmentType: json["appointment_type"],
        user: json["user"],
        facility: json["facility"],
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
        "facility": facility,
      };
}
