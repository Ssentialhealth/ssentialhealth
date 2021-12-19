// To parse this JSON data, do
//
//     final insuranceAgentModel = insuranceAgentModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/insurance_agent_service.dart';

List<InsuranceAgentModel> insuranceAgentModelListFromJson(String str) =>
    List<InsuranceAgentModel>.from(json.decode(str).map((x) => InsuranceAgentModel.fromJson(x)));

InsuranceAgentModel insuranceAgentModelFromJson(String str) => InsuranceAgentModel.fromJson(json.decode(str));

String insuranceAgentModelToJson(List<InsuranceAgentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final insuranceAgentModelProvider = FutureProvider.autoDispose((ref) async {
  final service = ref.watch(insuranceAgentServiceProvider);
  final data = await service.fetchAgents();
  return data;
});

class InsuranceAgentModel {
  InsuranceAgentModel({
    @required this.id,
    @required this.name,
    @required this.phoneNumber,
    @required this.email,
    @required this.location,
    @required this.overview,
    @required this.profileImgUrl,
    @required this.insuarance,
  });

  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String location;
  final String overview;
  final String profileImgUrl;
  final int insuarance;

  factory InsuranceAgentModel.fromJson(Map<String, dynamic> json) => InsuranceAgentModel(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        location: json["location"],
        overview: json["overview"],
        profileImgUrl: json["profile_img_url"],
        insuarance: json["insuarance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "location": location,
        "overview": overview,
        "profile_img_url": profileImgUrl,
        "insuarance": insuarance,
      };
}
