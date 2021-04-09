import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/profile/userProfileBloc.dart';
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

  Future<Hotlines> fetchHotlines(String country)async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/emergency/hotlines?country=$country");
    if(response.statusCode != 200){
      throw Exception('Error Fetching Hotlines');
    }

    print(response.body);
    final hotlinesJson = response.body;
    return hotlinesFromJson(hotlinesJson);
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
      operationTime,onlinePrice,
      personalPrice, followPrice,onlinePriceB,onlinePriceC, personalBPrice,followBPrice) async {
    Map<String, dynamic> healthInfo = Map();
    healthInfo['health_institution'] = healthInstitution;
    healthInfo['care_type'] = careType;
    healthInfo['practitioner'] = practitioner;
    healthInfo['speciality'] = speciality;
    healthInfo['affiliated_institution'] = affiliatedInstitution;

    Map<String, dynamic> onlineBook = Map();
    onlineBook['upto_15_mins'] = onlinePrice;
    onlineBook['upto_30_mins'] = onlinePriceB;
    onlineBook['upto_1_hour'] = onlinePriceC;

    Map<String, dynamic> inPersonBook = Map();
    inPersonBook['per_visit'] = personalPrice;
    inPersonBook['per_hour'] = personalBPrice;

    Map<String, dynamic> followUpBook = Map();
    followUpBook['per_visit'] = followPrice;
    followUpBook['per_hour'] = followBPrice;

    Map<String, dynamic> ratesInfo = Map();
    ratesInfo['online_booking'] = onlineBook;
    ratesInfo['in_person_booking'] = inPersonBook;
    ratesInfo['follow_up_visit'] = followUpBook;


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
      throw Exception(response.body);
    }
    final createProfileJson = jsonDecode(response.body);
    return PractitionerProfile.fromJson(createProfileJson);
  }

  Future<Profile> createProfile(String surname, phone,photo,
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
    _payLoad['profile_img_url'] = phone;
    _payLoad['phone_number'] = code + photo;
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
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token
        },
        body: jsonEncode(_payLoad)
    );
    print(response.body);
    print(_token);
    print(_payLoad);

    if (response.statusCode != 200) {
      throw Exception("Please Enter Fill all the Fields");
    }

    if(!response.body.startsWith('{"id":')){
      print("No ID");
    }else{
      print("NO");
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
      _showSnackBar(response.body.substring(11,response.body.length - 3));
      throw Exception('Error Occurred');
    } else {
      addStringToSF(loginModel.access, loginModel.user.userCategory,
          loginModel.user.fullNames,loginModel.user.email);
    }
    final loginJson = jsonDecode(response.body);
    return LoginModel.fromJson(loginJson);
  }


}

addStringToSF(String value,String userType,String fullName,String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = User(email: email,fullNames: fullName);

  // Map<String, dynamic> map ={
  //   'name': user.fullNames,
  //   'email': user.email,
  // };
  // String rawJson = jsonEncode(map);
  // prefs.setString('userInfo', rawJson);

  prefs.setString('token', value);
  prefs.setString('userType', userType);
  prefs.setString('fullName', fullName);
  prefs.setString('email', email);
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token');
  return stringValue;
}

void _showSnackBar(message) {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      )
  );
}

