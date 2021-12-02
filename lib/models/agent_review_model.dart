import 'dart:convert';

import 'package:flutter/material.dart';

AgentReviewModel agentReviewModelFromJson(String str) => AgentReviewModel.fromJson(json.decode(str));

List<AgentReviewModel> agentReviewModelListFromJson(String str) => List<AgentReviewModel>.from(json.decode(str).map((x) => AgentReviewModel.fromJson(x)));

String agentReviewModelListToJson(List<AgentReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String agentReviewModelToJson(AgentReviewModel data) => json.encode(data.toJson());

class AgentReviewModel {
  AgentReviewModel({
    @required this.comment,
    @required this.agent,
    @required this.user,
    @required this.rating,
    @required this.id,
  });

  final String comment;
  final int agent;
  final int user;
  final double rating;
  final int id;

  factory AgentReviewModel.fromJson(Map<String, dynamic> json) => AgentReviewModel(
        comment: json["comment"],
        agent: json["agent"],
        user: json["user"],
        rating: json["rating"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "agent": agent,
        "user": user,
        "rating": rating,
        "id": id,
      };
}
