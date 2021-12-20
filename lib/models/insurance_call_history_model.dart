// To parse this JSON data, do
//
//     final callHistoryModel = callHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

InsuranceCallHistoryModel insuranceCallHistoryModelFromJson(String str) => InsuranceCallHistoryModel.fromJson(json.decode(str));

String insuranceCallHistoryListModelToJson(List<InsuranceCallHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<InsuranceCallHistoryModel> insuranceCallHistoryListModelFromJson(String str) =>
    List<InsuranceCallHistoryModel>.from(json.decode(str).map((x) => InsuranceCallHistoryModel.fromJson(x)));

String insuranceCallHistoryModelToJson(InsuranceCallHistoryModel data) => json.encode(data.toJson());

class InsuranceCallHistoryModel {
  InsuranceCallHistoryModel({
    @required this.id,
    @required this.duration,
    @required this.startTime,
    @required this.endTime,
    @required this.user,
    @required this.insurance,
  });

  final int id;
  final String startTime;
  final String endTime;
  final dynamic duration;
  final int user;
  final int insurance;

  factory InsuranceCallHistoryModel.fromJson(Map<String, dynamic> json) => InsuranceCallHistoryModel(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        user: json["user"],
        duration: json["duration"],
        insurance: json["insurance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "started_at": startTime,
        "ended_at": endTime,
        "duration": duration,
        "user": user,
        "insurance": insurance,
      };
}
