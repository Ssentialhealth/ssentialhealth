import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/mental_wellness_service_provider.dart';

List<MentalWellnessModel> mentalWellnessModelFromJson(String str) =>
    List<MentalWellnessModel>.from(json.decode(str).map((x) => MentalWellnessModel.fromJson(x)));

String mentalWellnessModelToJson(List<MentalWellnessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final mentalWellnessModelProvider = FutureProvider.autoDispose<MentalWellnessModel>((ref) async {
  final service = ref.watch(mentalWellnessServiceProvider);
  final data = await service.getMentalWellnessData();
  return data;
});

class MentalWellnessModel {
  MentalWellnessModel({
    @required this.id,
    @required this.mentalWellness,
    @required this.resourceLink,
  });

  final int id;
  final String mentalWellness;
  final int resourceLink;

  factory MentalWellnessModel.fromJson(Map<String, dynamic> json) => MentalWellnessModel(
        id: json["id"],
        mentalWellness: json["mental_wellness"],
        resourceLink: json["resource_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mental_wellness": mentalWellness,
        "resource_link": resourceLink,
      };
}
