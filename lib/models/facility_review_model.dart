// To parse this JSON data, do
//
//     final facilityReviewModel = facilityReviewModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

FacilityReviewModel facilityReviewModelFromJson(String str) => FacilityReviewModel.fromJson(json.decode(str));

List<FacilityReviewModel> facilityReviewModelListFromJson(String str) =>
    List<FacilityReviewModel>.from(json.decode(str).map((x) => FacilityReviewModel.fromJson(x)));

String facilityReviewModelListToJson(List<FacilityReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String facilityReviewModelToJson(FacilityReviewModel data) => json.encode(data.toJson());

class FacilityReviewModel {
  FacilityReviewModel({
    @required this.comments,
    @required this.affordability,
    @required this.customerCare,
    @required this.serviceProductsAvailability,
    @required this.timely,
    @required this.facility,
    @required this.user,
    @required this.rating,
    @required this.id,
  });

  final String comments;
  final double affordability;
  final double customerCare;
  final double serviceProductsAvailability;
  final double timely;
  final int facility;
  final int user;
  final double rating;
  final int id;

  factory FacilityReviewModel.fromJson(Map<String, dynamic> json) => FacilityReviewModel(
        comments: json["comments"],
        affordability: json["affordability"],
        customerCare: json["customer_care"],
        serviceProductsAvailability: json["service_products_availability"],
        timely: json["timely"],
        facility: json["facility"],
        user: json["user"],
        rating: json["rating"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "comments": comments,
        "affordability": affordability,
        "customer_care": customerCare,
        "service_products_availability": serviceProductsAvailability,
        "timely": timely,
        "facility": facility,
        "user": user,
        "rating": rating,
        "id": id,
      };
}
