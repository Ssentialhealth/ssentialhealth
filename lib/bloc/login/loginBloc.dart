import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/bloc/login/loginEvent.dart';
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/repository/loginRepo.dart';

import 'loginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({@required this.loginRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SendLoginPayLoad) {
      yield LoginLoading();
      try {
        final LoginModel loginModel = await loginRepository.userLogin(event.email, event.password);
        if (loginModel != null) {
          yield LoginLoaded(loginModel);
        } else {
          yield LoginInitial();
        }
      } catch (e) {
        yield LoginError(e.toString());
      }
    }
  }
}
