import 'package:flutter/material.dart';
import 'package:pocket_health/screens/feedback_screen.dart';
import 'package:pocket_health/screens/profile_screen.dart';
import 'package:pocket_health/screens/wait_screen.dart';
import 'package:pocket_health/screens/contact_us.dart';


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

      home: ProfileScreen(),

    );
  }

}




