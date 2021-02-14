import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class SendLoginPayLoad extends LoginEvent{
  final String email;
  final String password;
  SendLoginPayLoad({@required this.email,@required this.password});
}
