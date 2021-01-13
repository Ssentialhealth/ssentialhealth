import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_health/services/auth_service.dart';

import 'package:rxdart/rxdart.dart';


import '../mixins/ValidationMixin.dart';


class FormBloc with ValidationMixin {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  // getters
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get addError => _errorMessage.sink.add;
  // streams
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get errorMessage => _password.stream;


  Stream<bool> get submitValidForm =>
      Rx.combineLatest3(email, password,errorMessage ,(e, p,er) => true);

  var authInfo;
//register
  dynamic register(BuildContext context)async{
    authInfo = AuthService();

    final res = await authInfo.register(_email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;

    if(data['status']!= 200){
      addError(data['message']);
    }else{
      addError(null);
      AuthService.setToken(data['token'],data['refreshToken'] );
      Navigator.pushNamed(context, '/home');
      return data;
    }

  }

  dynamic login(BuildContext context)async{
    authInfo = AuthService();

    final res = await authInfo.login(_email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;

    if(data['status']!= 200){
      addError(data['message']);
    }else{
      addError(null);
      AuthService.setToken(data['token'],data['refreshToken'] );
      Navigator.pushNamed(context, '/home');
      return data;
    }

  }


//login

  dispose() {
    _email.close();
    _password.close();
    _errorMessage.close();
  }
}



