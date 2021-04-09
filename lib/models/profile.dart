class Profile {
  int id;
  int user;
  String surname;
  String phoneNumber;
  String dateOfBirth;
  String gender;
  String residence;
  String country;
  String bloodGroup;
  List<PreviousAdmissions> previousAdmissions;
  String chronicCondition;
  String mentalConditions;
  List<String> disabilities;
  List<String> longTermMedications;
  List<String> familyChronicConditions;
  List<String> recreationalDrugUse;
  List<String> drugAllergies;
  List<String> foodAllergies;
  String profileImgUrl;

  Profile(
      {this.id,
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
        this.profileImgUrl});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    surname = json['surname'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    residence = json['residence'];
    country = json['country'];
    bloodGroup = json['blood_group'];
    if (json['previous_admissions'] != null) {
      previousAdmissions = new List<PreviousAdmissions>();
      json['previous_admissions'].forEach((v) {
        previousAdmissions.add(new PreviousAdmissions.fromJson(v));
      });
    }
    chronicCondition = json['chronic_condition'];
    mentalConditions = json['mental_conditions'];
    disabilities = json['disabilities'].cast<String>();
    longTermMedications = json['long_term_medications'].cast<String>();
    familyChronicConditions = json['family_chronic_conditions'].cast<String>();
    recreationalDrugUse = json['recreational_drug_use'].cast<String>();
    drugAllergies = json['drug_allergies'].cast<String>();
    foodAllergies = json['food_allergies'].cast<String>();
    profileImgUrl = json['profile_img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['surname'] = this.surname;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['residence'] = this.residence;
    data['country'] = this.country;
    data['blood_group'] = this.bloodGroup;
    if (this.previousAdmissions != null) {
      data['previous_admissions'] =
          this.previousAdmissions.map((v) => v.toJson()).toList();
    }
    data['chronic_condition'] = this.chronicCondition;
    data['mental_conditions'] = this.mentalConditions;
    data['disabilities'] = this.disabilities;
    data['long_term_medications'] = this.longTermMedications;
    data['family_chronic_conditions'] = this.familyChronicConditions;
    data['recreational_drug_use'] = this.recreationalDrugUse;
    data['drug_allergies'] = this.drugAllergies;
    data['food_allergies'] = this.foodAllergies;
    data['profile_img_url'] = this.profileImgUrl;
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