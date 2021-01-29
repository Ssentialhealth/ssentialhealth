import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                color: Color(0xFF00FFFF),
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset("assets/images/download.png", height: 50,)),
                      ),
                    ),
                    Text("Nicholas Dani",style: mediumTextStyle(),),
                    Spacer(flex: 2,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
