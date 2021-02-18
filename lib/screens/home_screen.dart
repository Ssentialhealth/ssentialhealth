import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pocket_health/screens/practitioner_info_screen.dart';
import 'package:pocket_health/screens/profile_screen.dart';
import 'package:pocket_health/widgets/card_item.dart';
import 'package:pocket_health/widgets/category_card.dart';
import 'package:pocket_health/widgets/welcome_dart.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/size_config.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _type = "...";



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/mental_health.png", "text": "Mental Health"},
      {"icon": "assets/images/wellness.png", "text": "Wellness"},
      {"icon": "assets/images/first_aid.png", "text": "FirstAid"},
      {"icon": "assets/images/health_insurace.png", "text": "Health Insuran.."},

    ];

    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF00FFFF));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE7FFFF),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/homelogo.png',fit: BoxFit.scaleDown,),
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                          child: GestureDetector(
                            onTap: ()async{
                              _type = await getStringValuesSF();

                              print(_type);
                              if(_type == 'individual'){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                              }else if(_type == 'health practitioner'){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PractitionerInfo()));
                              }else{

                              }
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset("assets/images/download.png", height: 50,)),
                          ),
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
                CardItem(
                  image: "assets/images/adult_unwell.png",
                  text: "Adult Unwell- Check Symptoms \n& Conditions",
                ),
                CardItem(
                  image: "assets/images/child_health_ immunisation.png",
                  text: "Child Health & Immunisation",
                ),
                CardItem(
                  image: "assets/images/pregnancy_lactation.png",
                  text: "Pregnancy & Lactation",
                ),
                SizedBox(height: 8,),
                WelcomeCard(),
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
                CardItem(
                  image: "assets/images/doctors_practitioners.png",
                  text: "Doctors & Practitioners",
                ),
                CardItem(
                  image: "assets/images/hospital_facilities.png",
                  text: "Health Facilities",
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Image.asset('assets/images/icons/Home_colored.png',height: 20,width:20,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: new Image.asset('assets/images/icons/emergency red.png',height: 20,width:20,),
              label: 'Emergency',
            ),
            BottomNavigationBarItem(
              icon: new Image.asset('assets/images/icons/doctor_consult_colored.png',height: 20,width:20,),
              label: 'Consult',
            ),BottomNavigationBarItem(
              icon: new Image.asset('assets/images/icons/settings.png',height: 20,width:20,),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff163C4D),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),

      ),
    );
  }
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('userType');
  return stringValue;
}

