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
    @required this.startedAt,
    @required this.endedAt,
    @required this.user,
  });

  final int id;
  final String startedAt;
  final String endedAt;
  final int user;

  factory CallHistoryModel.fromJson(Map<String, dynamic> json) => CallHistoryModel(
        id: json["id"],
        startedAt: json["started_at"],
        endedAt: json["ended_at"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "started_at": startedAt,
        "ended_at": endedAt,
        "user": user,
      };
}
