import 'package:flutter/material.dart';

class FacilityScreen extends StatefulWidget {
  @override
  _FacilityScreenState createState() => _FacilityScreenState();
}

class _FacilityScreenState extends State<FacilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facility"),
        centerTitle: true,
        backgroundColor: Color(0xFF00FFFF),
      ),
    );
  }
}
