import 'package:flutter/material.dart';
import 'package:pocket_health/screens/Login/loginScreen.dart';
import 'package:pocket_health/screens/forgot_password.dart';
import 'package:pocket_health/screens/home.dart';
import 'package:pocket_health/screens/signup_screen.dart';

import 'blocs/form_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FormProvider(
      child: MaterialApp(
        title: 'Login_bloc_screen',
        initialRoute: '/login',
        darkTheme: ThemeData.dark(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    if(routeSettings.name == '/login'){
      return MaterialPageRoute(builder: (_) =>Login());
    }
    if(routeSettings.name == '/forgotPassword') {
      return MaterialPageRoute(builder: (_) => ForgotPassword());
    }
    if(routeSettings.name == '/signUp') {
      return MaterialPageRoute(builder: (_) => SignUp());
    }
    return MaterialPageRoute(builder: (_) => Home());
  }

}




