import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/pregnancy_lactation_service.dart';

List<PregnancyLactationResourcesModel> pregnancyLactationResourcesModelFromJson(String str) =>
    List<PregnancyLactationResourcesModel>.from(json.decode(str).map((x) => PregnancyLactationResourcesModel.fromJson(x)));

String pregnancyLactationResourcesModelToJson(List<PregnancyLactationResourcesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final pregnancyLactationResourcesModelFutureProvider = FutureProvider.autoDispose<List<PregnancyLactationResourcesModel>>((ref) async {
  final pregService = ref.watch(pregServiceProvider);
  final data = await pregService.getPregnancyLactationResources();
  return data;
});

class PregnancyLactationResourcesModel {
  PregnancyLactationResourcesModel({
    @required this.id,
    @required this.resourceInfo,
    @required this.information,
    @required this.country,
    @required this.phoneNumber,
    @required this.email,
  });

  final int id;
  final String resourceInfo;
  final String information;
  final String country;
  final String phoneNumber;
  final String email;

  factory PregnancyLactationResourcesModel.fromJson(Map<String, dynamic> json) => PregnancyLactationResourcesModel(
        id: json["id"],
        resourceInfo: json["resource_info"],
        information: json["information"],
        country: json["country"],
        phoneNumber: json["phone_number"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resource_info": resourceInfo,
        "information": information,
        "country": country,
        "phone_number": phoneNumber,
        "email": email,
      };
}
