import 'package:flutter/material.dart';
import 'package:pocket_health/Authenticate.dart';
import 'package:pocket_health/screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ssential App',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white
      ),

      home: Authenticate(),

    );
  }

}




