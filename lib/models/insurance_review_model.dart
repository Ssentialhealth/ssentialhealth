import 'dart:convert';

import 'package:flutter/material.dart';

InsuranceReviewModel insuranceReviewModelFromJson(String str) => InsuranceReviewModel.fromJson(json.decode(str));

List<InsuranceReviewModel> insuranceReviewModelListFromJson(String str) =>
    List<InsuranceReviewModel>.from(json.decode(str).map((x) => InsuranceReviewModel.fromJson(x)));

String insuranceReviewModelListToJson(List<InsuranceReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String insuranceReviewModelToJson(InsuranceReviewModel data) => json.encode(data.toJson());

class InsuranceReviewModel {
  InsuranceReviewModel({
    @required this.comment,
    @required this.healthInsuarance,
    @required this.user,
    @required this.rating,
    @required this.id,
  });

  final String comment;
  final int healthInsuarance;
  final int user;
  final double rating;
  final int id;

  factory InsuranceReviewModel.fromJson(Map<String, dynamic> json) => InsuranceReviewModel(
        comment: json["comment"],
        healthInsuarance: json["health_insuarance"],
        user: json["user"],
        rating: json["rating"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "health_insuarance": healthInsuarance,
        "user": user,
        "rating": rating,
        "id": id,
      };
}
