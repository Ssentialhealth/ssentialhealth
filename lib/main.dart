import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_health/Authenticate.dart';
import 'package:pocket_health/screens/forgot_password.dart';
import 'package:pocket_health/screens/home_screen.dart';
import 'package:pocket_health/screens/profile_screen.dart';
import 'package:pocket_health/screens/splash_screen.dart';
import 'package:pocket_health/screens/wait_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ssential App',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white
      ),

      home: WaitScreen(),

    );
  }

}




