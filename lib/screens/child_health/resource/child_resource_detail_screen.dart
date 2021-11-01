import 'package:flutter/material.dart';

import 'child_resource_detail_data.dart';

class ChildResourceDetailScreen extends StatefulWidget {
  final String title;
  ChildResourceDetailScreen({this.title});

  @override
  _ChildResourceDetailScreenState createState() => _ChildResourceDetailScreenState();
}

class _ChildResourceDetailScreenState extends State<ChildResourceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailData(),
            ],
          ),
        ),
      ),
    );
  }
}
