import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class AuthService{
  final baseUrl = 'http://ssential.herokuapp.com';
  static final SESSION = FlutterSession();

  Future<dynamic> register(String email,String pin )async{
    try{
      var res = await http.post('$baseUrl/auth/register', body: {
        'email': email,
        'pin': pin,
      });

      return res?.body;
    } finally{
      //function perform
    }
  }

  Future<dynamic> login(String email,String pin )async{
    try{
      var res = await http.post('$baseUrl/auth/login', body: {
        'email': email,
        'auth_token': 'vdjhcbdvhdvfdvnjfdvfkdvfbvflvsie',
        'user_id':'',
      });

      return res?.body;
    } finally{
      //function perform
    }
  }

  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
     await SESSION.set('tokens', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }

  static removeToken()async {
    await SESSION.prefs.clear();
}

}

class _AuthData {
  String token, refreshToken,userId;
  _AuthData(this.token, this.refreshToken, {this.userId});

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['userId'] = userId;
    return data;
  }

}