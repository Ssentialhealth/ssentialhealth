class PractitionerProfile {
  String surname;
  String phoneNumber;
  String location;
  String region;
  HealthInfo healthInfo;
  RatesInfo ratesInfo;

  PractitionerProfile(
      {this.surname,
        this.phoneNumber,
        this.location,
        this.region,
        this.healthInfo,
        this.ratesInfo});

  PractitionerProfile.fromJson(Map<String, dynamic> json) {
    surname = json['surname'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    region = json['region'];
    healthInfo = json['health_info'] != null
        ? new HealthInfo.fromJson(json['health_info'])
        : null;
    ratesInfo = json['rates_info'] != null
        ? new RatesInfo.fromJson(json['rates_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surname'] = this.surname;
    data['phone_number'] = this.phoneNumber;
    data['location'] = this.location;
    data['region'] = this.region;
    if (this.healthInfo != null) {
      data['health_info'] = this.healthInfo.toJson();
    }
    if (this.ratesInfo != null) {
      data['rates_info'] = this.ratesInfo.toJson();
    }
    return data;
  }
}

class HealthInfo {
  String healthInstitution;
  String careType;
  String practitioner;
  String speciality;
  String affiliatedInstitution;

  HealthInfo(
      {this.healthInstitution,
        this.careType,
        this.practitioner,
        this.speciality,
        this.affiliatedInstitution});

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
  FollowUpVisit followUpVisit;
  FollowUpVisit inPersonBooking;

  RatesInfo({this.onlineBooking, this.followUpVisit, this.inPersonBooking});

  RatesInfo.fromJson(Map<String, dynamic> json) {
    onlineBooking = json['online_booking'] != null
        ? new OnlineBooking.fromJson(json['online_booking'])
        : null;
    followUpVisit = json['follow_up_visit'] != null
        ? new FollowUpVisit.fromJson(json['follow_up_visit'])
        : null;
    inPersonBooking = json['in_person_booking'] != null
        ? new FollowUpVisit.fromJson(json['in_person_booking'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlineBooking != null) {
      data['online_booking'] = this.onlineBooking.toJson();
    }
    if (this.followUpVisit != null) {
      data['follow_up_visit'] = this.followUpVisit.toJson();
    }
    if (this.inPersonBooking != null) {
      data['in_person_booking'] = this.inPersonBooking.toJson();
    }
    return data;
  }
}

class OnlineBooking {
  int upto15Mins;
  int upto30Mins;
  int upto1Hour;

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

class FollowUpVisit {
  int perVisit;
  int perHour;

  FollowUpVisit({this.perVisit, this.perHour});

  FollowUpVisit.fromJson(Map<String, dynamic> json) {
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

