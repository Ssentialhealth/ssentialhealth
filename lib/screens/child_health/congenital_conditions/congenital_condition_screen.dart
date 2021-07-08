import 'package:flutter/material.dart';

import 'congenital_data.dart';

class CongenitalScreen extends StatefulWidget {
  const CongenitalScreen({Key key}) : super(key: key);

  @override
  _CongenitalScreenState createState() => _CongenitalScreenState();
}

class _CongenitalScreenState extends State<CongenitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Chronic Conditions",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: CongenitalData(),
    );
  }
}
