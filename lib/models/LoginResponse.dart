class LoginResponse {
  String token;

  LoginResponse({this.token});

  LoginResponse.fromJson(Map<String, dynamic>json){
    token = json['auth_token'];
  }

  Map<String, dynamic>toJson() {
    final Map<String, dynamic> data = new Map<String,dynamic>();
    data['auth_token'] = this.token;
    return data;
  }


}


