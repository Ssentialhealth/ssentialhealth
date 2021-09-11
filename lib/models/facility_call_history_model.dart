// To parse this JSON data, do
//
//     final callHistoryModel = callHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

FacilityCallHistoryModel facilityCallHistoryModelFromJson(String str) => FacilityCallHistoryModel.fromJson(json.decode(str));

String facilityCallHistoryListModelToJson(List<FacilityCallHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<FacilityCallHistoryModel> facilityCallHistoryListModelFromJson(String str) =>
    List<FacilityCallHistoryModel>.from(json.decode(str).map((x) => FacilityCallHistoryModel.fromJson(x)));

String facilityCallHistoryModelToJson(FacilityCallHistoryModel data) => json.encode(data.toJson());

class FacilityCallHistoryModel {
  FacilityCallHistoryModel({
    @required this.id,
    @required this.duration,
    @required this.startTime,
    @required this.endTime,
    @required this.user,
    @required this.facility,
  });

  final int id;
  final String startTime;
  final String endTime;
  final dynamic duration;
  final int user;
  final int facility;

  factory FacilityCallHistoryModel.fromJson(Map<String, dynamic> json) => FacilityCallHistoryModel(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        user: json["user"],
        duration: json["duration"],
        facility: json["facility"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "started_at": startTime,
        "ended_at": endTime,
        "duration": duration,
        "user": user,
        "facility": facility,
      };
}
