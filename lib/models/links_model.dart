import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/links_service.dart';

List<LinkModel> linksFromJson(String str) => List<LinkModel>.from(json.decode(str).map((x) => LinkModel.fromJson(x)));

String linksToJson(List<LinkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final linksModelProvider = FutureProvider.autoDispose<List<LinkModel>>((ref) async {
  final service = ref.watch(linkServiceProvider);
  final data = await service.getLinks();
  return data;
});

class LinkModel {
  LinkModel({
    @required this.id,
    @required this.linkName,
    @required this.resourceLink,
  });

  final int id;
  final String linkName;
  final String resourceLink;

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        id: json["id"],
        linkName: json["link_name"],
        resourceLink: json["resource_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link_name": linkName,
        "resource_link": resourceLink,
      };
}
