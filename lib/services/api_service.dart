import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/ForgotPassword.dart';
import 'package:pocket_health/models/PractitionerProfile.dart';
import 'package:pocket_health/models/emergency_contact.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final http.Client httpClient;
  String _token = "...";
  BuildContext buildContext;


  ApiService(this.httpClient) : assert(httpClient != null);

  Future<List<Hotlines>> fetchHotlines()async {
    final response = await this.httpClient.get(getHotlines);
    if(response.statusCode != 200){
      throw Exception('Error Fetching Hotlines');
    }
   final hotlinesJson = jsonDecode(response.body);
    return Hotlines.fromJson(hotlinesJson);
  }

  Future<EmergencyContact> addContacts(String ambulanceName, countryCode,
      ambulancePhone, insurerName,
      insuranceNumber, insurerNumber,
      emergenceName, emergencyRelation, emergencyNumber,) async {
    Map<String, dynamic> mainLoad = Map();

    Map<String, dynamic> emergency = Map();
    emergency['name'] = emergenceName;
    emergency['phone_number'] = emergencyNumber;
    emergency['relationship'] = emergencyRelation;


    Map<String, dynamic> healthI = Map();
    healthI['name'] = insurerName;
    healthI['insurance_number'] = insuranceNumber;
    healthI['contacts'] = [insurerNumber];

    Map<String, dynamic> ambulance = Map();
    ambulance['name'] = ambulanceName;
    ambulance['contacts'] = [ambulancePhone];

    mainLoad['emergency_contacts'] = [emergency];
    mainLoad['health_insurers'] = [healthI];
    mainLoad['ambulance_services'] = [ambulance];


    _token = await getStringValuesSF();
    final response = await httpClient.post(Uri.encodeFull(addContactsEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token
        },
        body: jsonEncode(mainLoad)
    );
    print(response.body);
    print(_token);
    print(mainLoad);

    if (response.statusCode != 200) {
      throw Exception('error creating profile');
    }
    final createProfileJson = jsonDecode(response.body);
    return EmergencyContact.fromJson(createProfileJson);
  }

  Future<PractitionerProfile> createPractitioner(String surname, location,
      region, phone,
      healthInstitution, careType,
      practitioner, speciality, affiliatedInstitution,
      operationTime, onlineBooking, inPerson, followUp, onlinePrice,
      personalPrice, followPrice) async {
    Map<String, dynamic> healthInfo = Map();
    healthInfo['health_institution'] = healthInstitution;
    healthInfo['care_type'] = careType;
    healthInfo['practitioner'] = practitioner;
    healthInfo['speciality'] = speciality;
    healthInfo['affiliated_institution'] = affiliatedInstitution;

    Map<String, dynamic> onlineBook = Map();
    onlineBook['upto_15_mins'] = onlinePrice;
    onlineBook['upto_30_mins'] = onlinePrice;
    onlineBook['upto_1_hour'] = onlinePrice;

    Map<String, dynamic> inPersonBook = Map();
    inPersonBook['per_visit'] = onlinePrice;
    inPersonBook['per_hour'] = onlinePrice;

    Map<String, dynamic> followUpBook = Map();
    followUpBook['per_visit'] = onlinePrice;
    followUpBook['per_hour'] = onlinePrice;

    Map<String, dynamic> ratesInfo = Map();
    ratesInfo['online_booking'] = onlineBook;
    ratesInfo['in_person_booking'] = inPersonBook;
    ratesInfo['follow_up_visit'] = followUpBook;


    Map<String, dynamic> follow = Map();
    follow['follow_up_visit'] = followUp;

    Map<String, dynamic> _payLoad = Map();
    _payLoad['surname'] = surname;
    _payLoad['phone_number'] = operationTime + phone;
    _payLoad['location'] = location;
    _payLoad['region'] = region;
    _payLoad['health_info'] = healthInfo;
    _payLoad['rates_info'] = ratesInfo;
    _token = await getStringValuesSF();
    final response = await httpClient.post(
        Uri.encodeFull(createPractitionerProfileEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token
        },
        body: jsonEncode(_payLoad)
    );
    print(response.body);
    print(_token);
    print(_payLoad);

    if (response.statusCode != 200) {
      throw Exception('error creating profile');
    }
    final createProfileJson = jsonDecode(response.body);
    return PractitionerProfile.fromJson(createProfileJson);
  }

  Future<Profile> createProfile(String surname, phone,
      dob, gender,
      residence, country,
      blood, chronic, longTerm,
      date, condition, code, disabilities,
      recreational, drugAllergies, foodAllergies) async {
    Map<String, dynamic> _payLoad = Map();
    Map<String, dynamic> data = Map();
    Map<String, dynamic> previous = Map();
    previous['admission_date'] = date;
    previous['conditions'] = [condition];


    List<String> dis = [data['disabilities'] = disabilities];
    List<String> longterm = [data['long_term_medications'] = longTerm];
    List<String> family = [data['family_chronic_conditions'] = chronic];
    List<String> drugs = [data['recreational_drug_use'] = recreational];
    List<String> dAllergies = [data['recreational_drug_use'] = drugAllergies];
    List<String> fAllergies = [data['recreational_drug_use'] = foodAllergies];

    _payLoad['surame'] = surname;
    _payLoad['phone_number'] = code + phone;
    _payLoad['date_of_birth'] = dob;
    _payLoad['gender'] = gender;
    _payLoad['residence'] = residence;
    _payLoad['country'] = country;
    _payLoad['blood_group'] = blood;
    _payLoad['chronic_condition'] = chronic;
    _payLoad['previous_admissions'] = [previous];
    _payLoad['disabilities'] = dis;
    _payLoad['long_term_medications'] = longterm;
    _payLoad['family_chronic_conditions'] = family;
    _payLoad['recreational_drug_use'] = drugs;
    _payLoad['drug_allergies'] = dAllergies;
    _payLoad['food_allergies'] = fAllergies;
    _token = await getStringValuesSF();
    final response = await httpClient.post(
        Uri.encodeFull(createProfileEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token
        },
        body: jsonEncode(_payLoad)
    );
    print(response.body);
    print(_token);
    print(_payLoad);

    if (response.statusCode != 200) {
      throw Exception('error creating profile');
    }
    final createProfileJson = jsonDecode(response.body);
    return Profile.fromJson(createProfileJson);
  }

  Future<ForgotPassword> resetPassword(String email) async {
    Map<String, String> _payLoad = Map();
    _payLoad['email'] = email;
    final response = await this.httpClient.post(
        Uri.encodeFull(forgotPassEndpoint),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode(_payLoad)
    );
    print(response.body);
    if (response.statusCode != 204) {
      throw Exception('Error creating Profile');
    }
    final resetPasswordJson = jsonDecode(response.body);
    return ForgotPassword.fromJson(resetPasswordJson);
  }

  Future<LoginModel> login(String email, String password) async {
    Map<String, String> payLoad = Map();
    payLoad['email'] = email;
    payLoad['password'] = password;

    final response = await this.httpClient.post(Uri.encodeFull(loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payLoad)
    );
    print(response.body);
    LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
    if (response.statusCode != 200) {
      throw Exception('Error Occurred');
    } else {
      addStringToSF(loginModel.access, loginModel.user.userCategory,
          loginModel.user.fullNames);
    }
    final loginJson = jsonDecode(response.body);
    return LoginModel.fromJson(loginJson);
  }


}

addStringToSF(String value,String userType,String fullName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', value);
  prefs.setString('userType', userType);
  prefs.setString('fullName', fullName);
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token');
  return stringValue;
}

