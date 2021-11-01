import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/mental_wellness_resources_service.dart';

List<MentalWellnessResourcesModel> mentalWellnessResourcesModelFromJson(String str) =>
    List<MentalWellnessResourcesModel>.from(json.decode(str).map((x) => MentalWellnessResourcesModel.fromJson(x)));

String mentalWellnessResourcesModelToJson(List<MentalWellnessResourcesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final mentalWellnessResourcesModelProvider = FutureProvider.autoDispose<List<MentalWellnessResourcesModel>>((ref) async {
  final service = ref.watch(mentalWellnessResourcesServiceProvider);
  final data = await service.getMentalWellnessResourcesData();
  return data;
});

class MentalWellnessResourcesModel {
  MentalWellnessResourcesModel({
    @required this.id,
    @required this.mentalWellnessResources,
    @required this.resourceLink,
  });

  final int id;
  final String mentalWellnessResources;
  final int resourceLink;

  factory MentalWellnessResourcesModel.fromJson(Map<String, dynamic> json) => MentalWellnessResourcesModel(
        id: json["id"],
        mentalWellnessResources: json["mental_wellness_resources"],
        resourceLink: json["resource_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mental_wellness_resources": mentalWellnessResources,
        "resource_link": resourceLink,
      };
}
