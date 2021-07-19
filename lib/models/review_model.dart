// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

List<ReviewModel> listOfReviewModelFromJson(String str) => List<ReviewModel>.from(json.decode(str).map((x) => ReviewModel.fromJson(x)));

String listOfReviewModelToJson(List<ReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel {
  ReviewModel({
    @required this.rating,
    @required this.comment,
    @required this.profile,
    @required this.user,
  });

  final double rating;
  final String comment;
  final int profile;
  final int user;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        rating: json["rating"],
        comment: json["comment"],
        profile: json["profile"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "profile": profile,
        "user": user,
      };
}
