import 'package:flutter/material.dart';
import 'package:pocket_health/screens/AdultUnwell/condition_details/condition_details_data.dart';

class ConditionDetailsScreen extends StatefulWidget {
  final String title;
  ConditionDetailsScreen({this.title});
  @override
  _ConditionDetailsState createState() => _ConditionDetailsState();
}

class _ConditionDetailsState extends State<ConditionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailsData(),
              ],
            ),
          )
      )
    );
  }
}
