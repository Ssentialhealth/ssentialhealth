// To parse this JSON data, do
//
//     final callHistoryModel = callHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

CallHistoryModel callHistoryModelFromJson(String str) => CallHistoryModel.fromJson(json.decode(str));

String callHistoryListModelToJson(List<CallHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<CallHistoryModel> callHistoryListModelFromJson(String str) => List<CallHistoryModel>.from(json.decode(str).map((x) => CallHistoryModel.fromJson(x)));

String callHistoryModelToJson(CallHistoryModel data) => json.encode(data.toJson());

class CallHistoryModel {
  CallHistoryModel({
    @required this.id,
    @required this.duration,
    @required this.startTime,
    @required this.endTime,
    @required this.user,
    @required this.profile,
  });

  final int id;
  final String startTime;
  final String endTime;
  final dynamic duration;
  final int user;
  final int profile;

  factory CallHistoryModel.fromJson(Map<String, dynamic> json) => CallHistoryModel(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        user: json["user"],
        duration: json["duration"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() =>
		  {
        "id": id,
        "started_at": startTime,
        "ended_at": endTime,
        "duration": duration,
        "user": user,
        "profile": profile,
      };
}
