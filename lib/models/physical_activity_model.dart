import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/physical_activity_service.dart';

List<PhysicalActivityModel> physicalActivityModelFromJson(String str) =>
    List<PhysicalActivityModel>.from(json.decode(str).map((x) => PhysicalActivityModel.fromJson(x)));

String physicalActivityModelToJson(List<PhysicalActivityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final physicalActivityModelProvider = FutureProvider.autoDispose<PhysicalActivityModel>((ref) async {
  final service = ref.watch(physicalActivityServiceProvider);
  final data = await service.getPhysicalActivityData();
  return data;
});

class PhysicalActivityModel {
  PhysicalActivityModel({
    @required this.id,
    @required this.physicalActivity,
    @required this.resourceLink,
  });

  final int id;
  final String physicalActivity;
  final int resourceLink;

  factory PhysicalActivityModel.fromJson(Map<String, dynamic> json) => PhysicalActivityModel(
        id: json["id"],
        physicalActivity: json["physical_activity"],
        resourceLink: json["resource_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "physical_activity": physicalActivity,
        "resource_link": resourceLink,
      };
}
