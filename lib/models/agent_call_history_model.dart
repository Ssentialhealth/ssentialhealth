// To parse this JSON data, do
//
//     final callHistoryModel = callHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

AgentCallHistoryModel agentCallHistoryModelFromJson(String str) => AgentCallHistoryModel.fromJson(json.decode(str));

String agentCallHistoryListModelToJson(List<AgentCallHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<AgentCallHistoryModel> agentCallHistoryListModelFromJson(String str) =>
    List<AgentCallHistoryModel>.from(json.decode(str).map((x) => AgentCallHistoryModel.fromJson(x)));

String agentCallHistoryModelToJson(AgentCallHistoryModel data) => json.encode(data.toJson());

class AgentCallHistoryModel {
  AgentCallHistoryModel({
    @required this.id,
    @required this.duration,
    @required this.startTime,
    @required this.endTime,
    @required this.user,
    @required this.agent,
  });

  final int id;
  final String startTime;
  final String endTime;
  final dynamic duration;
  final int user;
  final int agent;

  factory AgentCallHistoryModel.fromJson(Map<String, dynamic> json) => AgentCallHistoryModel(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        user: json["user"],
        duration: json["duration"],
        agent: json["agent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "started_at": startTime,
        "ended_at": endTime,
        "duration": duration,
        "user": user,
        "agent": agent,
      };
}
