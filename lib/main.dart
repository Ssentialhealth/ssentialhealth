import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_health/Authenticate.dart';
import 'package:pocket_health/screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF00FFFF), //or set color with: Color(0xFF0000FF)
    ));
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




