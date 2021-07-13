import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  String practitionerID;
  String reviewerID;
  String datePosted;
  String reviewText;
  double rating;

  ReviewModel({this.practitionerID, this.reviewerID, this.datePosted, this.reviewText, this.rating});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    practitionerID = json['practitionerID'];
    reviewerID = json['reviewerID'];
    datePosted = json['datePosted'];
    reviewText = json['reviewText'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['practitionerID'] = this.practitionerID;
    data['reviewerID'] = this.reviewerID;
    data['datePosted'] = this.datePosted;
    data['reviewText'] = this.reviewText;
    data['rating'] = this.rating;
    return data;
  }
}
