import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:pocket_health/repository/all_users_service.dart';

List<UserProfileModel> allUserProfileModelsFromJson(String str) => List<UserProfileModel>.from(json.decode(str).map((x) => UserProfileModel.fromJson(x)));

String allUserProfileModelsToJson(List<UserProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final allUserProfilesProvider = FutureProvider.autoDispose<List<UserProfileModel>>((ref) async {
  final service = ref.watch(allUsersServiceProvider);
  final data = await service.fetchAllUsers();
  return data;
});

class UserProfileModel {
  UserProfileModel({
    this.user,
    this.surname,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.residence,
    this.country,
    this.bloodGroup,
    this.previousAdmissions,
    this.chronicCondition,
    this.mentalConditions,
    this.disabilities,
    this.longTermMedications,
    this.familyChronicConditions,
    this.recreationalDrugUse,
    this.drugAllergies,
    this.foodAllergies,
    this.profileImgUrl,
    this.healthProvision,
  });

  final int user;
  final String surname;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final Gender gender;
  final String residence;
  final String country;
  final BloodGroup bloodGroup;
  final List<PreviousAdmission> previousAdmissions;
  final ChronicCondition chronicCondition;
  final String mentalConditions;
  final List<Disability> disabilities;
  final List<LongTermMedication> longTermMedications;
  final List<ChronicCondition> familyChronicConditions;
  final List<RecreationalDrugUse> recreationalDrugUse;
  final List<DrugAllergy> drugAllergies;
  final List<FoodAllergy> foodAllergies;
  final String profileImgUrl;
  final bool healthProvision;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        user: json["user"],
        surname: json["surname"],
        phoneNumber: json["phone_number"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: genderValues.map[json["gender"]],
        residence: json["residence"],
        country: json["country"],
        bloodGroup: bloodGroupValues.map[json["blood_group"]],
        previousAdmissions: List<PreviousAdmission>.from(json["previous_admissions"].map((x) => PreviousAdmission.fromJson(x))),
        chronicCondition: chronicConditionValues.map[json["chronic_condition"]],
        mentalConditions: json["mental_conditions"],
        disabilities: List<Disability>.from(json["disabilities"].map((x) => disabilityValues.map[x])),
        longTermMedications: List<LongTermMedication>.from(json["long_term_medications"].map((x) => longTermMedicationValues.map[x])),
        familyChronicConditions: List<ChronicCondition>.from(json["family_chronic_conditions"].map((x) => chronicConditionValues.map[x])),
        recreationalDrugUse: List<RecreationalDrugUse>.from(json["recreational_drug_use"].map((x) => recreationalDrugUseValues.map[x])),
        drugAllergies: List<DrugAllergy>.from(json["drug_allergies"].map((x) => drugAllergyValues.map[x])),
        foodAllergies: List<FoodAllergy>.from(json["food_allergies"].map((x) => foodAllergyValues.map[x])),
        profileImgUrl: json["profile_img_url"],
        healthProvision: json["health_provision"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "surname": surname,
        "phone_number": phoneNumber,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": genderValues.reverse[gender],
        "residence": residence,
        "country": country,
        "blood_group": bloodGroupValues.reverse[bloodGroup],
        "previous_admissions": List<dynamic>.from(previousAdmissions.map((x) => x.toJson())),
        "chronic_condition": chronicConditionValues.reverse[chronicCondition],
        "mental_conditions": mentalConditions,
        "disabilities": List<dynamic>.from(disabilities.map((x) => disabilityValues.reverse[x])),
        "long_term_medications": List<dynamic>.from(longTermMedications.map((x) => longTermMedicationValues.reverse[x])),
        "family_chronic_conditions": List<dynamic>.from(familyChronicConditions.map((x) => chronicConditionValues.reverse[x])),
        "recreational_drug_use": List<dynamic>.from(recreationalDrugUse.map((x) => recreationalDrugUseValues.reverse[x])),
        "drug_allergies": List<dynamic>.from(drugAllergies.map((x) => drugAllergyValues.reverse[x])),
        "food_allergies": List<dynamic>.from(foodAllergies.map((x) => foodAllergyValues.reverse[x])),
        "profile_img_url": profileImgUrl,
        "health_provision": healthProvision,
      };
}

enum BloodGroup { O, BLOOD_GROUP_O, A, AB }

final bloodGroupValues = EnumValues({"A-": BloodGroup.A, "AB+": BloodGroup.AB, "O-": BloodGroup.BLOOD_GROUP_O, "O+": BloodGroup.O});

enum ChronicCondition { CONVULSION_DISORDER, ECZEMA, HEART_FAILURE, CANCER, CHRONIC_CONDITION_CANCER, CONGENITAL, ASTHMA, ADF }

final chronicConditionValues = EnumValues({
  "adf": ChronicCondition.ADF,
  "Asthma": ChronicCondition.ASTHMA,
  "cancer": ChronicCondition.CANCER,
  "Cancer,": ChronicCondition.CHRONIC_CONDITION_CANCER,
  "Congenital,": ChronicCondition.CONGENITAL,
  "Convulsion disorder": ChronicCondition.CONVULSION_DISORDER,
  "Eczema": ChronicCondition.ECZEMA,
  "Heart Failure": ChronicCondition.HEART_FAILURE
});

enum Disability { NEUROMUSCULAR, HEARING, SMTHING, MW, LL, SEEING }

final disabilityValues = EnumValues({
  "Hearing": Disability.HEARING,
  "ll": Disability.LL,
  "mw": Disability.MW,
  "Neuromuscular": Disability.NEUROMUSCULAR,
  "Seeing": Disability.SEEING,
  "smthing": Disability.SMTHING
});

enum DrugAllergy { PENICILLIN, SULPHUR, JME, CEPHALOSPORINS }

final drugAllergyValues =
    EnumValues({"Cephalosporins": DrugAllergy.CEPHALOSPORINS, "jme": DrugAllergy.JME, "Penicillin": DrugAllergy.PENICILLIN, "Sulphur": DrugAllergy.SULPHUR});

enum FoodAllergy { MEAT, EGGS, PEANUT, LACTOSE, FISH }

final foodAllergyValues =
    EnumValues({"Eggs": FoodAllergy.EGGS, "Fish": FoodAllergy.FISH, "lactose": FoodAllergy.LACTOSE, "Meat": FoodAllergy.MEAT, "Peanut": FoodAllergy.PEANUT});

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

enum LongTermMedication { ANTI_HEART_FAILURE, ANTI_CANCER, OTHER_ANTI_DIABETES, AFD, ANTI_HYPERTENSION }

final longTermMedicationValues = EnumValues({
  "afd": LongTermMedication.AFD,
  "Anti-cancer": LongTermMedication.ANTI_CANCER,
  "Anti- heart failure": LongTermMedication.ANTI_HEART_FAILURE,
  "Anti-hypertension": LongTermMedication.ANTI_HYPERTENSION,
  "Other anti-diabetes": LongTermMedication.OTHER_ANTI_DIABETES
});

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

enum RecreationalDrugUse { MARIJUANA, TOBACCO, CIGARRETES, ALCOHOL, COCAINE }

final recreationalDrugUseValues = EnumValues({
  "Alcohol": RecreationalDrugUse.ALCOHOL,
  "cigarretes": RecreationalDrugUse.CIGARRETES,
  "Cocaine": RecreationalDrugUse.COCAINE,
  "Marijuana": RecreationalDrugUse.MARIJUANA,
  "Tobacco,": RecreationalDrugUse.TOBACCO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
