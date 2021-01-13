import 'package:flutter/material.dart';
import 'package:pocket_health/screens/loginScreen.dart';
import 'package:pocket_health/screens/forgot_password.dart';
import 'package:pocket_health/screens/home_screen.dart';
import 'package:pocket_health/screens/sign_in_screen.dart';
import 'package:pocket_health/screens/signup_screen.dart';
import 'package:pocket_health/services/auth_service.dart';

import 'providers/form_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login_bloc_screen',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F)
      ),
      home: SignInScreen(),
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => Login(),
        '/signUp': (_) => SignUpScreen(),
        '/forgotPassword': (_) => ForgotPassword(),
      },
    );
  }

}




