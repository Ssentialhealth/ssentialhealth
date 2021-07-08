import 'package:flutter/material.dart';
import 'package:pocket_health/screens/AdultUnwell/symptoms/symptom_data.dart';

class SymptomDetailsScreen extends StatefulWidget {
  final String title;
  SymptomDetailsScreen({this.title});
  @override
  _SymptomDetailsScreenState createState() => _SymptomDetailsScreenState();
}

class _SymptomDetailsScreenState extends State<SymptomDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SymptomData()
          ],
          ),
        ),
      ),
    );
  }
}
