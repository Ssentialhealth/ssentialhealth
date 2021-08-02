import 'package:flutter/material.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/screens/emergency_screens/emergency_hotlines_screen.dart';
import 'package:pocket_health/screens/emergency_screens/fire_and_disaster_screen.dart';
import 'package:pocket_health/screens/emergency_screens/health_insurer.dart';
import 'package:pocket_health/screens/emergency_screens/police_security_screen.dart';
import 'package:pocket_health/screens/emergency_screens/sexual_gender_screen.dart';
import 'package:pocket_health/screens/emergency_screens/sexual_reproduction_screen.dart';
import 'package:pocket_health/screens/emergency_screens/suicide_mental_screen.dart';
import 'package:pocket_health/widgets/hotline_item.dart';
import 'package:pocket_health/widgets/widget.dart';

import 'accident_rescue_screen.dart';
import 'children_hotline_screen.dart';

class HotlineScreen extends StatefulWidget {
  @override
  _HotlineScreenState createState() => _HotlineScreenState();
}

class _HotlineScreenState extends State<HotlineScreen> {
  String code;
  Hotlines hotlines = new Hotlines();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FFFF),
      appBar: AppBar(
        title: Text("Emergency Hotlines"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
	          padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              children: [
                Column(
                  children: [
                    //Ambulance and Medical//
                    SizedBox(
                      height: 6,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Ambulance and Medical",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyHotlines()));
                        }),
                    divider(),
                    //Health Insurer//
                    SizedBox(
                      height: 6,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Health Insurer",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HealthInsurer()));
                        }),
                    divider(),
                    //Fire and Disaster//
                    SizedBox(
                      height: 6,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Fire and Disaster",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FireAndDisaster()));
                        }),
                    divider(),
                    //Police and Security//
                    SizedBox(
                      height: 6,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Police and Security",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PoliceSecurity()));
                        }),
                    divider(),
                    //Accident Rescue//
                    SizedBox(
                      height: 8,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Accident Rescue(Road/Air/Water)",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AccidentRescue()));
                        }),
                    divider(),
                    //Suicide//
                    SizedBox(
                      height: 8,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Suicide and Mental Health Hotlines",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SuicideMental()));
                        }),
                    divider(),
                    //Sexual and Gender Based//
                    SizedBox(
                      height: 8,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Sexual and Gender Based Violence Hotlines",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SexualAndGender()));
                        }),
                    divider(),
                    //Children Hotlines//
                    SizedBox(
                      height: 8,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Children Hotlines",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChildrenHotline()));
                        }),
                    divider(),
                    //Sexual and Reproductive Health Hotlines
                    SizedBox(
                      height: 8,
                    ),
                    divider(),
                    HotlineItem(
                        text: "Sexual and Reproductive Health Hotlines",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SexualReproduction()));
                        }),
                    divider(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
