// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<UserProfileModel> userProfileModelFromJson(String str) => List<UserProfileModel>.from(json.decode(str).map((x) => UserProfileModel.fromJson(x)));

String userProfileModelToJson(List<UserProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfileModel {
  UserProfileModel({
    @required this.id,
    @required this.user,
    @required this.surname,
    @required this.phoneNumber,
    @required this.dateOfBirth,
    @required this.gender,
    @required this.residence,
    @required this.country,
    @required this.bloodGroup,
    @required this.previousAdmissions,
    @required this.chronicCondition,
    @required this.mentalConditions,
    @required this.disabilities,
    @required this.longTermMedications,
    @required this.familyChronicConditions,
    @required this.recreationalDrugUse,
    @required this.drugAllergies,
    @required this.foodAllergies,
    @required this.profileImgUrl,
    @required this.healthProvision,
  });

  final int id;
  final int user;
  final String surname;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String gender;
  final String residence;
  final String country;
  final String bloodGroup;
  final List<PreviousAdmission> previousAdmissions;
  final String chronicCondition;
  final String mentalConditions;
  final List<String> disabilities;
  final List<String> longTermMedications;
  final List<String> familyChronicConditions;
  final List<String> recreationalDrugUse;
  final List<String> drugAllergies;
  final List<String> foodAllergies;
  final String profileImgUrl;
  final bool healthProvision;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json["id"],
        user: json["user"],
        surname: json["surname"],
        phoneNumber: json["phone_number"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        residence: json["residence"],
        country: json["country"],
        bloodGroup: json["blood_group"],
        previousAdmissions: List<PreviousAdmission>.from(json["previous_admissions"].map((x) => PreviousAdmission.fromJson(x))),
        chronicCondition: json["chronic_condition"],
        mentalConditions: json["mental_conditions"],
        disabilities: List<String>.from(json["disabilities"].map((x) => x)),
        longTermMedications: List<String>.from(json["long_term_medications"].map((x) => x)),
        familyChronicConditions: List<String>.from(json["family_chronic_conditions"].map((x) => x)),
        recreationalDrugUse: List<String>.from(json["recreational_drug_use"].map((x) => x)),
        drugAllergies: List<String>.from(json["drug_allergies"].map((x) => x)),
        foodAllergies: List<String>.from(json["food_allergies"].map((x) => x)),
        profileImgUrl: json["profile_img_url"],
        healthProvision: json["health_provision"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "surname": surname,
        "phone_number": phoneNumber,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "residence": residence,
        "country": country,
        "blood_group": bloodGroup,
        "previous_admissions": List<dynamic>.from(previousAdmissions.map((x) => x.toJson())),
        "chronic_condition": chronicCondition,
        "mental_conditions": mentalConditions,
        "disabilities": List<dynamic>.from(disabilities.map((x) => x)),
        "long_term_medications": List<dynamic>.from(longTermMedications.map((x) => x)),
        "family_chronic_conditions": List<dynamic>.from(familyChronicConditions.map((x) => x)),
        "recreational_drug_use": List<dynamic>.from(recreationalDrugUse.map((x) => x)),
        "drug_allergies": List<dynamic>.from(drugAllergies.map((x) => x)),
        "food_allergies": List<dynamic>.from(foodAllergies.map((x) => x)),
        "profile_img_url": profileImgUrl,
        "health_provision": healthProvision,
      };
}

class PreviousAdmission {
  PreviousAdmission({
    @required this.admissionDate,
    @required this.conditions,
  });

  final DateTime admissionDate;
  final List<String> conditions;

  factory PreviousAdmission.fromJson(Map<String, dynamic> json) => PreviousAdmission(
        admissionDate: DateTime.parse(json["admission_date"]),
        conditions: List<String>.from(json["conditions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "admission_date":
            "${admissionDate.year.toString().padLeft(4, '0')}-${admissionDate.month.toString().padLeft(2, '0')}-${admissionDate.day.toString().padLeft(2, '0')}",
        "conditions": List<dynamic>.from(conditions.map((x) => x)),
      };
}
