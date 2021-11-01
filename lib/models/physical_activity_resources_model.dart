import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/physical_activity_resources_service.dart';

List<PhysicalActivityResourcesModel> physicalActivityResourcesModelFromJson(String str) =>
    List<PhysicalActivityResourcesModel>.from(json.decode(str).map((x) => PhysicalActivityResourcesModel.fromJson(x)));

String physicalActivityResourcesModelToJson(List<PhysicalActivityResourcesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final physicalActivityResourcesModelProvider = FutureProvider.autoDispose<List<PhysicalActivityResourcesModel>>((ref) async {
  final service = ref.watch(physicalActivityResourcesServiceProvider);
  final data = await service.getPhysicalActivityResourcesData();
  return data;
});

class PhysicalActivityResourcesModel {
  PhysicalActivityResourcesModel({
    @required this.id,
    @required this.physicalActivityResources,
    @required this.resourceLink,
  });

  final int id;
  final String physicalActivityResources;
  final int resourceLink;

  factory PhysicalActivityResourcesModel.fromJson(Map<String, dynamic> json) => PhysicalActivityResourcesModel(
        id: json["id"],
        physicalActivityResources: json["physical_activity_resources"],
        resourceLink: json["resource_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "physical_activity_resources": physicalActivityResources,
        "resource_link": resourceLink,
      };
}
