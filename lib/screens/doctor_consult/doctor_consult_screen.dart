import 'package:flutter/material.dart';

class DoctorConsultScreen extends StatefulWidget {
  @override
  _DoctorConsultScreenState createState() => _DoctorConsultScreenState();
}

class _DoctorConsultScreenState extends State<DoctorConsultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Consult"),
        centerTitle: true,
        backgroundColor: Color(0xFF00FFFF),
      ),
    );
  }
}
