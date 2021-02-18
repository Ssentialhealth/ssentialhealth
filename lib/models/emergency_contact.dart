class EmergencyContact {
  List<EmergencyContacts> emergencyContacts;
  List<HealthInsurers> healthInsurers;
  List<AmbulanceServices> ambulanceServices;

  EmergencyContact(
      {this.emergencyContacts, this.healthInsurers, this.ambulanceServices});

  EmergencyContact.fromJson(Map<String, dynamic> json) {
    if (json['emergency_contacts'] != null) {
      emergencyContacts = new List<EmergencyContacts>();
      json['emergency_contacts'].forEach((v) {
        emergencyContacts.add(new EmergencyContacts.fromJson(v));
      });
    }
    if (json['health_insurers'] != null) {
      healthInsurers = new List<HealthInsurers>();
      json['health_insurers'].forEach((v) {
        healthInsurers.add(new HealthInsurers.fromJson(v));
      });
    }
    if (json['ambulance_services'] != null) {
      ambulanceServices = new List<AmbulanceServices>();
      json['ambulance_services'].forEach((v) {
        ambulanceServices.add(new AmbulanceServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.emergencyContacts != null) {
      data['emergency_contacts'] =
          this.emergencyContacts.map((v) => v.toJson()).toList();
    }
    if (this.healthInsurers != null) {
      data['health_insurers'] =
          this.healthInsurers.map((v) => v.toJson()).toList();
    }
    if (this.ambulanceServices != null) {
      data['ambulance_services'] =
          this.ambulanceServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmergencyContacts {
  String name;
  String phoneNumber;
  String relationship;

  EmergencyContacts({this.name, this.phoneNumber, this.relationship});

  EmergencyContacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    relationship = json['relationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['relationship'] = this.relationship;
    return data;
  }
}

class HealthInsurers {
  String name;
  String insuranceNumber;
  List<String> contacts;

  HealthInsurers({this.name, this.insuranceNumber, this.contacts});

  HealthInsurers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    insuranceNumber = json['insurance_number'];
    contacts = json['contacts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['insurance_number'] = this.insuranceNumber;
    data['contacts'] = this.contacts;
    return data;
  }
}

class AmbulanceServices {
  String name;
  List<String> contacts;

  AmbulanceServices({this.name, this.contacts});

  AmbulanceServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contacts = json['contacts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contacts'] = this.contacts;
    return data;
  }
}