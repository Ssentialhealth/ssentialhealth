import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pocket_health/models/ForgotPassword.dart';

import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/screens/forgot_password.dart';
import 'package:pocket_health/utils/constants.dart';

class ApiService {
  final http.Client httpClient;

  ApiService(this.httpClient) : assert(httpClient != null);

  Future<Profile> createProfile() async {
    final response = await httpClient.post(Uri.encodeFull(createProfileEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + "_token"
        },
    );
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

}