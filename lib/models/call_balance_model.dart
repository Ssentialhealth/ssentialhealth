import 'dart:convert';

import 'package:meta/meta.dart';

CallBalanceModel callBalanceModelFromJson(String str) => CallBalanceModel.fromJson(json.decode(str));

List<CallBalanceModel> callBalanceListModelFromJson(String str) => List<CallBalanceModel>.from(json.decode(str).map((x) => CallBalanceModel.fromJson(x)));

String callBalanceListModelToJson(List<CallBalanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String callBalanceModelToJson(CallBalanceModel data) => json.encode(data.toJson());

class CallBalanceModel {
  CallBalanceModel({
    @required this.id,
    @required this.paymentType,
    @required this.amount,
    @required this.balance,
    @required this.currency,
    @required this.createdAt,
    @required this.user,
  });

  final int id;
  final String paymentType;
  final String amount;
  final String balance;
  final String currency;
  final DateTime createdAt;
  final int user;

  factory CallBalanceModel.fromJson(Map<String, dynamic> json) => CallBalanceModel(
        id: json["id"],
        paymentType: json["payment_type"],
        amount: json["amount"],
        balance: json["balance"],
        currency: json["currency"],
        createdAt: DateTime.parse(json["created_at"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_type": paymentType,
        "amount": amount,
        "balance": balance,
        "currency": currency,
        "created_at": createdAt.toIso8601String(),
        "user": user,
      };
}
