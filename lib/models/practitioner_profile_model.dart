import 'dart:convert';

List<PractitionerProfileModel> practitionerProfileListModelFromJson(String str) =>
    List<PractitionerProfileModel>.from(json.decode(str).map((x) => PractitionerProfileModel.fromJson(x)));

PractitionerProfileModel practitionerProfileModelFromJson(String str) => PractitionerProfileModel.fromJson(json.decode(str));

String practitionerProfileModelToJson(List<PractitionerProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PractitionerProfileModel {
  int user;
  HealthInfo healthInfo;
  RatesInfo ratesInfo;
  String surname;
  String phoneNumber;
  bool available;
  String location;
  String region;
  String profileImgUrl;

  PractitionerProfileModel(
      {this.user, this.healthInfo, this.ratesInfo, this.surname, this.phoneNumber, this.available, this.location, this.region, this.profileImgUrl});

  PractitionerProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    healthInfo = json['health_info'] != null ? new HealthInfo.fromJson(json['health_info']) : HealthInfo();
    ratesInfo = json['rates_info'] != null ? new RatesInfo.fromJson(json['rates_info']) : RatesInfo();
    surname = json['surname'];
    phoneNumber = json['phone_number'];
    available = json['available'];
    location = json['location'];
    region = json['region'];
    profileImgUrl = json['profile_img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.healthInfo != null) {
      data['health_info'] = this.healthInfo.toJson();
    }
    if (this.ratesInfo != null) {
      data['rates_info'] = this.ratesInfo.toJson();
    }
    data['surname'] = this.surname;
    data['phone_number'] = this.phoneNumber;
    data['available'] = this.available;
    data['location'] = this.location;
    data['region'] = this.region;
    data['profile_img_url'] = this.profileImgUrl;
    return data;
  }
}

class HealthInfo {
  String healthInstitution;
  String careType;
  String practitioner;
  String speciality;
  String affiliatedInstitution;

  HealthInfo({this.healthInstitution, this.careType, this.practitioner, this.speciality, this.affiliatedInstitution});

  HealthInfo.fromJson(Map<String, dynamic> json) {
    healthInstitution = json['health_institution'];
    careType = json['care_type'];
    practitioner = json['practitioner'];
    speciality = json['speciality'];
    affiliatedInstitution = json['affiliated_institution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['health_institution'] = this.healthInstitution;
    data['care_type'] = this.careType;
    data['practitioner'] = this.practitioner;
    data['speciality'] = this.speciality;
    data['affiliated_institution'] = this.affiliatedInstitution;
    return data;
  }
}

class RatesInfo {
  OnlineBooking onlineBooking;
  InPersonBooking inPersonBooking;
  InPersonBooking followUpVisit;

  RatesInfo({this.onlineBooking, this.inPersonBooking, this.followUpVisit});

  RatesInfo.fromJson(Map<String, dynamic> json) {
    onlineBooking = json['online_booking'] != null ? new OnlineBooking.fromJson(json['online_booking']) : OnlineBooking();
    inPersonBooking = json['in_person_booking'] != null ? new InPersonBooking.fromJson(json['in_person_booking']) : InPersonBooking();
    followUpVisit = json['follow_up_visit'] != null ? new InPersonBooking.fromJson(json['follow_up_visit']) : InPersonBooking();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlineBooking != null) {
      data['online_booking'] = this.onlineBooking.toJson();
    }
    if (this.inPersonBooking != null) {
      data['in_person_booking'] = this.inPersonBooking.toJson();
    }
    if (this.followUpVisit != null) {
      data['follow_up_visit'] = this.followUpVisit.toJson();
    }
    return data;
  }
}

class OnlineBooking {
  String upto15Mins;
  String upto30Mins;
  String upto1Hour;

  OnlineBooking({this.upto15Mins, this.upto30Mins, this.upto1Hour});

  OnlineBooking.fromJson(Map<String, dynamic> json) {
    upto15Mins = json['upto_15_mins'];
    upto30Mins = json['upto_30_mins'];
    upto1Hour = json['upto_1_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upto_15_mins'] = this.upto15Mins;
    data['upto_30_mins'] = this.upto30Mins;
    data['upto_1_hour'] = this.upto1Hour;
    return data;
  }
}

class InPersonBooking {
  String perVisit;
  String perHour;

  InPersonBooking({this.perVisit, this.perHour});

  InPersonBooking.fromJson(Map<String, dynamic> json) {
    perVisit = json['per_visit'];
    perHour = json['per_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_visit'] = this.perVisit;
    data['per_hour'] = this.perHour;
    return data;
  }
}
