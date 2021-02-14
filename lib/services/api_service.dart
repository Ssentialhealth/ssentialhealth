import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/ForgotPassword.dart';
import 'package:pocket_health/models/loginModel.dart';

import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/screens/forgot_password.dart';
import 'package:pocket_health/screens/home_screen.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final http.Client httpClient;
  String _token = "...";
  BuildContext buildContext;



  ApiService(this.httpClient) : assert(httpClient != null);

  Future<Profile> createProfile(
      String surname, phone,
      dob, gender,
      residence,country,
      blood, chronic,longTerm,
      date,condition,code,disabilities,
      recreational,drugAllergies,foodAllergies

      ) async {
    Map<String,dynamic> _payLoad = Map();
    Map<String,dynamic> data =  Map();
    Map<String,dynamic> previous = Map();
    previous['admission_date'] = date;
    previous['conditions'] = [condition];



    List<String> dis= [data['disabilities'] = disabilities];
    List<String> longterm= [data['long_term_medications'] = longTerm];
    List<String> family= [data['family_chronic_conditions'] = chronic];
    List<String> drugs= [data['recreational_drug_use'] = recreational];
    List<String> dAllergies= [data['recreational_drug_use'] = drugAllergies];
    List<String> fAllergies= [data['recreational_drug_use'] = foodAllergies];

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
    final response = await httpClient.post(Uri.encodeFull(createProfileEndpoint),
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
    Map<String,String> _payLoad = Map();
    _payLoad['email'] = email;
    final response = await this.httpClient.post(Uri.encodeFull(forgotPassEndpoint),
    headers:{
      "Content-Type": "application/json"
      },
      body: jsonEncode(_payLoad)
    );
    print(response.body);
    if(response.statusCode != 204){
      throw Exception('Error creating Profile');
    }
    final resetPasswordJson = jsonDecode(response.body);
    return ForgotPassword.fromJson(resetPasswordJson);
  }

  Future<LoginModel> login(String email,String password) async{
    Map<String,String> payLoad = Map();
    payLoad['email'] = email;
    payLoad['password'] = password;

    final response = await this.httpClient.post(Uri.encodeFull(loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payLoad)
    );
    print(response.body);
    LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
    if(response.statusCode != 200){
      throw Exception('Error Occurred');
    }else{
      addStringToSF(loginModel.access);
    }
    final loginJson = jsonDecode(response.body);
    return LoginModel.fromJson(loginJson);

  }


}

addStringToSF(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', value);
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token');
  return stringValue;
}

