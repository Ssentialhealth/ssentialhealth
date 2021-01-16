import 'package:flutter/material.dart';
import 'package:pocket_health/services/auth_service.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pocket_health/widgets/widget.dart';

import '../size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/mental_health.png", "text": "Mental Health"},
      {"icon": "assets/images/wellness.png", "text": "Wellness"},
      {"icon": "assets/images/first_aid.png", "text": "FirstAid"},
      {"icon": "assets/images/health_insurace.png", "text": "Health Insuran.."},

    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE7FFFF),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 74,
                  color: Color(0xFF00FFFF),
                  alignment: Alignment.topCenter,
                  child:   Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Image.asset(
                          'assets/images/homelogo.png',
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(height: 8,),

                    ],
                  ),

                ),
                SizedBox(height: 5,),
                Container(
                  height: 55,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset("assets/images/first_aid.png", height: 50,)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            decoration: searchFieldInputDecoration("Search for services"),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                cardItem("assets/images/adult_unwell.png","Adult Unwell- Check Symptoms \n& Conditions",),
                cardItem("assets/images/child_health_ immunisation.png","Child Health & Immunisation",),
                cardItem("assets/images/pregnancy_lactation.png","Pregnancy & Lactation",),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      ...List.generate(categories.length, (index) =>
                      CategoryCard(icon: categories[index]["icon"],
                        text: categories[index]["text"],
                        press: () {},))
                    ]
                  ),
                ),
                SizedBox(height: 8,),
                cardItem("assets/images/doctors_practitioners.png","Doctors & Practitioners",),
                cardItem("assets/images/hospital_facilities.png","Health Facilities",),

              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [],
        // ),
      ),
    );
  }
}

