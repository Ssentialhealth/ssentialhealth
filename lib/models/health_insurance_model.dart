import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/health_insurance_service.dart';

List<HealthInsuranceModel> healthInsuranceModelListFromJson(String str) =>
    List<HealthInsuranceModel>.from(json.decode(str).map((x) => HealthInsuranceModel.fromJson(x)));

String healthInsuranceModelToJson(List<HealthInsuranceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
HealthInsuranceModel healthInsuranceModelFromJson(String str) => HealthInsuranceModel.fromJson(json.decode(str));

final healthInsuranceModelProvider = FutureProvider.autoDispose<List<HealthInsuranceModel>>((ref) async {
  final service = ref.watch(healthInsuranceServiceProvider);
  final data = await service.fetchHealthInsurances();
  return data;
});

class HealthInsuranceModel {
  HealthInsuranceModel({
    @required this.id,
    @required this.name,
    @required this.phoneNumber,
    @required this.email,
    @required this.location,
    @required this.overview,
    @required this.profileImgUrl,
  });

  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String location;
  final String overview;
  final String profileImgUrl;

  factory HealthInsuranceModel.fromJson(Map<String, dynamic> json) => HealthInsuranceModel(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        location: json["location"],
        overview: json["overview"],
        profileImgUrl: json["profile_img_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "location": location,
        "overview": overview,
        "profile_img_url": profileImgUrl,
      };
}
