import 'package:flutter/material.dart';

import 'organDetailsList.dart';

class OrganDetailsScreen extends StatefulWidget {
  final String title;
  OrganDetailsScreen({this.title});

  @override
  _OrganDetailsScreenState createState() => _OrganDetailsScreenState();
}

class _OrganDetailsScreenState extends State<OrganDetailsScreen> {
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Possible Cause Conditions",
                    style:TextStyle(
                        fontSize: 18,
                    )),
              ),
            ),
            SizedBox(height: 15,),
            OrganDetailsCard(),
          ],
        ),
      ),
    );
  }
}
