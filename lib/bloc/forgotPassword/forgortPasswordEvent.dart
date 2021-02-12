import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotPasswordEvent extends Equatable{
  const ForgotPasswordEvent();
    @override
  List<Object> get props => [];
}

class GetResetEmail extends ForgotPasswordEvent{
  final String email;
  GetResetEmail({@required this.email});
}