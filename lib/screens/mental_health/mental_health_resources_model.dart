import 'dart:convert';

import 'package:flutter_riverpod/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/mental_health_resources_service.dart';

List<MentalHealthResourcesModel> mentalResourcesModelFromJson(String str) =>
    List<MentalHealthResourcesModel>.from(json.decode(str).map((x) => MentalHealthResourcesModel.fromJson(x)));

String mentalResourcesModelToJson(List<MentalHealthResourcesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final mentalHealthResourcesModelFutureProvider = FutureProvider.autoDispose<List<MentalHealthResourcesModel>>((ref) async {
  final mentalHealthResourcesService = ref.watch(mentalHealthResourcesServiceProvider);
  final data = mentalHealthResourcesService.fetchMentalResources();
  return data;
});

class MentalHealthResourcesModel {
  MentalHealthResourcesModel({
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

  factory MentalHealthResourcesModel.fromJson(Map<String, dynamic> json) => MentalHealthResourcesModel(
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
