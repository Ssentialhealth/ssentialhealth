import 'package:flutter/material.dart';

import 'congenital_detail_data.dart';

class CongenitalDetailScreen extends StatefulWidget {
  final String title;
  CongenitalDetailScreen({this.title});

  @override
  _CongenitalDetailScreenState createState() => _CongenitalDetailScreenState();
}

class _CongenitalDetailScreenState extends State<CongenitalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CongenitalDetailsData(),
              ],
            ),
          )
      ),
    );
  }
}
