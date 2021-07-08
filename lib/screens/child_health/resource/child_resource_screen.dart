import 'package:flutter/material.dart';

import 'child_resource_data.dart';

class ChildResourceScreen extends StatefulWidget {
  const ChildResourceScreen({Key key}) : super(key: key);

  @override
  _ChildResourceState createState() => _ChildResourceState();
}

class _ChildResourceState extends State<ChildResourceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Child Resources",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ChildResourceData(),
              ],
            ),
          )
      )
    );
  }
}
