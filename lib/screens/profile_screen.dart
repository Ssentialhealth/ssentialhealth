import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocket_health/widgets/widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      color: Color(0xFF00FFFF),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset("assets/images/download.png", height: 70,)),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical:20),
                                child: Column(
                                  children: [
                                    Text("Nicholas Dani",style: mediumTextStyle()),
                                    SizedBox(height: 10,),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      lineHeight: 10.0,
                                      percent: 0.3,
                                      backgroundColor: Colors.white,
                                      progressColor: Color(0xff163C4D),
                                    ),


                                  ],
                                ),
                              ),
                              Spacer(flex: 2,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_forward_ios_outlined),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  color: Color(0xFFEAFCF6),
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
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Divider(height: 1,color: Color(0xFFC6C6C6),),
                        menuItems("assets/images/icons/Saved.png", "Saved"),
                        Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
                        menuItems("assets/images/icons/document.png", "Documents"),
                        Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
                        menuItems("assets/images/icons/insurance agency.png", "Insurance Agency"),
                        Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
                        menuItems("assets/images/icons/shared medical.png", "Shared Medical"),
                        Divider(height: 1,color: Color(0xFFC6C6C6)),
                     ],
                    ),
                  ),
                ),
                SizedBox(height: 9,),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 1,color: Color(0xFFC6C6C6),),
                      menuItems("assets/images/icons/help.png", "Help"),
                      Divider(color: Colors.black,indent: 10,endIndent: 10,),
                      menuItems("assets/images/icons/feedback.png", "Feedback"),
                      Divider(color: Colors.black,indent: 10,endIndent: 10,),
                      menuItems("assets/images/icons/contact us.png", "Contact Us"),
                      Divider(height: 1,color: Colors.black),
                    ],
                  ),
                ),
                SizedBox(height: 9,),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 1,color: Color(0xFFC6C6C6),),
                      menuItems("assets/images/icons/terms and conditions.png", "Terms & Conditions"),
                      Divider(color: Colors.black,indent: 10,endIndent: 10,),
                      menuItems("assets/images/icons/terms and conditions.png", "Privacy Policy"),
                      Divider(height: 1,color: Colors.black),
                    ],
                  ),
                ),

              ],
            ),
        ),
        ),
      ),
    );
  }
}

