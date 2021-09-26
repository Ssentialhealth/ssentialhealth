// To parse this JSON data, do
//
//     final acceptDeclineModel = acceptDeclineModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<AcceptDeclineModel> acceptDeclineModelListFromJson(String str) =>
    List<AcceptDeclineModel>.from(json.decode(str).map((x) => AcceptDeclineModel.fromJson(x)));

AcceptDeclineModel acceptDeclineModelFromJson(String str) => AcceptDeclineModel.fromJson(json.decode(str));

String acceptDeclineModelToJson(AcceptDeclineModel data) => json.encode(data.toJson());

String acceptDeclineListModelToJson(List<AcceptDeclineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AcceptDeclineModel {
  AcceptDeclineModel({
    @required this.id,
    @required this.phoneNumber,
    @required this.waitingStatus,
    @required this.user,
  });

  final int id;
  final String phoneNumber;
  final bool waitingStatus;
  final int user;

  factory AcceptDeclineModel.fromJson(Map<String, dynamic> json) => AcceptDeclineModel(
        id: json["id"],
        phoneNumber: json["phone_number"],
        waitingStatus: json["waiting_status"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "waiting_status": waitingStatus,
        "user": user,
      };
}
