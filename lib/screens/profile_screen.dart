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
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Row(
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
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset("assets/images/download.png", height: 70,)),
                          ),
                        ),
                        Text("Nicholas Dani",style: mediumTextStyle(),),
                        Spacer(flex: 2,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 60,
                color: Color(0xFFEFEFEF),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding:  EdgeInsets.only(left:25),
                            child: Text("Chat and Calls",style: TextStyle(fontWeight: FontWeight.w500),),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
              Divider(color: Colors.black,),
              menuItems("assets/images/icons/Saved.png", "Saved"),
              Divider(color: Colors.black,indent: 10,endIndent: 10,),
              menuItems("assets/images/icons/document.png", "Documents"),
              Divider(color: Colors.black,indent: 10,endIndent: 10,)

            ],
          ),

        ),
      ),
    );
  }
}
