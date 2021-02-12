class Profile {
  String surame;
  String phoneNumber;
  String dateOfBirth;
  String gender;
  String residence;
  String country;
  String bloodGroup;
  String chronicCondition;
  List<PreviousAdmissions> previousAdmissions;
  List<String> disabilities;
  List<String> longTermMedications;
  List<String> familyChronicConditions;
  List<String> recreationalDrugUse;
  List<String> drugAllergies;
  List<String> foodAllergies;

  Profile(
      {this.surame,
        this.phoneNumber,
        this.dateOfBirth,
        this.gender,
        this.residence,
        this.country,
        this.bloodGroup,
        this.chronicCondition,
        this.previousAdmissions,
        this.disabilities,
        this.longTermMedications,
        this.familyChronicConditions,
        this.recreationalDrugUse,
        this.drugAllergies,
        this.foodAllergies});

  Profile.fromJson(Map<String, dynamic> json) {
    surame = json['surame'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    residence = json['residence'];
    country = json['country'];
    bloodGroup = json['blood_group'];
    chronicCondition = json['chronic_condition'];
    if (json['previous_admissions'] != null) {
      previousAdmissions = new List<PreviousAdmissions>();
      json['previous_admissions'].forEach((v) {
        previousAdmissions.add(new PreviousAdmissions.fromJson(v));
      });
    }
    disabilities = json['disabilities'].cast<String>();
    longTermMedications = json['long_term_medications'].cast<String>();
    familyChronicConditions = json['family_chronic_conditions'].cast<String>();
    recreationalDrugUse = json['recreational_drug_use'].cast<String>();
    drugAllergies = json['drug_allergies'].cast<String>();
    foodAllergies = json['food_allergies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surame'] = this.surame;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['residence'] = this.residence;
    data['country'] = this.country;
    data['blood_group'] = this.bloodGroup;
    data['chronic_condition'] = this.chronicCondition;
    if (this.previousAdmissions != null) {
      data['previous_admissions'] =
          this.previousAdmissions.map((v) => v.toJson()).toList();
    }
    data['disabilities'] = this.disabilities;
    data['long_term_medications'] = this.longTermMedications;
    data['family_chronic_conditions'] = this.familyChronicConditions;
    data['recreational_drug_use'] = this.recreationalDrugUse;
    data['drug_allergies'] = this.drugAllergies;
    data['food_allergies'] = this.foodAllergies;
    return data;
  }
}

class PreviousAdmissions {
  String admissionDate;
  List<String> conditions;

  PreviousAdmissions({this.admissionDate, this.conditions});

  PreviousAdmissions.fromJson(Map<String, dynamic> json) {
    admissionDate = json['admission_date'];
    conditions = json['conditions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admission_date'] = this.admissionDate;
    data['conditions'] = this.conditions;
    return data;
  }
}
