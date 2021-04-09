import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorConsult extends StatefulWidget {
  @override
  _DoctorConsultState createState() => _DoctorConsultState();
}

class _DoctorConsultState extends State<DoctorConsult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Doctor Consult",style: TextStyle(color: Colors.black)),
    );
  }
}
