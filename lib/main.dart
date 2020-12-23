import 'package:flutter/material.dart';
import 'package:pocket_health/screens/Login/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
   
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen()
    );
  }
}




