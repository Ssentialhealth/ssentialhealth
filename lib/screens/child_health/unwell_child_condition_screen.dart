import 'package:flutter/material.dart';

import 'child_condition_details_data.dart';

class UnwellChildDetails extends StatefulWidget {

  final String title;
  UnwellChildDetails({this.title});

  @override
  _UnwellChildDetailsState createState() => _UnwellChildDetailsState();
}

class _UnwellChildDetailsState extends State<UnwellChildDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: ChildDetailsData(),
    );
  }
}
