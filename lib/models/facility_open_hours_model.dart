// To parse this JSON data, do
//
//     final facilityOpenHours = facilityOpenHoursFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<FacilityOpenHoursModel> facilityOpenHoursFromJson(String str) =>
    List<FacilityOpenHoursModel>.from(json.decode(str).map((x) => FacilityOpenHoursModel.fromJson(x)));

String facilityOpenHoursToJson(List<FacilityOpenHoursModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacilityOpenHoursModel {
  FacilityOpenHoursModel({
    @required this.facility,
    @required this.day,
    @required this.timeSlotFrom,
    @required this.timeSlotTo,
  });

  final int facility;
  final int day;
  final String timeSlotFrom;
  final String timeSlotTo;

  factory FacilityOpenHoursModel.fromJson(Map<String, dynamic> json) => FacilityOpenHoursModel(
        facility: json["facility"],
        day: json["day"],
        timeSlotFrom: json["time_slot_from"],
        timeSlotTo: json["time_slot_to"],
      );

  Map<String, dynamic> toJson() => {
        "facility": facility,
        "day": day,
        "time_slot_from": timeSlotFrom,
        "time_slot_to": timeSlotTo,
      };
}
