
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/loginModel.dart';

abstract class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginModel loginModel;
  @override
  List<LoginModel> get props => [loginModel];

  LoginLoaded(this.loginModel) : assert(loginModel != null);
}

class LoginLoading extends LoginState {

}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error): assert(error != null);

}