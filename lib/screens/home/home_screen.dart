import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pocket_health/screens/emergency_screens/emergency_hotlines_screen.dart';
import 'package:pocket_health/screens/profile/practitioner_info_screen.dart';
import 'package:pocket_health/screens/profile/profile_screen.dart';
import 'package:pocket_health/widgets/card_item.dart';
import 'package:pocket_health/widgets/category_card.dart';
import 'package:pocket_health/widgets/welcome_dart.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/size_config.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _type = "...";
  bool visibilityController = false;


   welcomeCard(){
    setState(() {
      if(_type != null){
        visibilityController = true;
        return WelcomeCard();
      }else{
        visibilityController = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/mental_health.png", "text": "Mental Health"},
      {"icon": "assets/images/wellness.png", "text": "Wellness"},
      {"icon": "assets/images/first_aid.png", "text": "First Aid"},
      {"icon": "assets/images/health_insurace.png", "text": "Health Insuran.."},

    ];

    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF00FFFF));
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //           width: 3,
                      //           color: Colors.white
                      //       ),
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     child: GestureDetector(
                      //       onTap: ()async{
                      //
                      //       },
                      //       child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(30),
                      //           child: Image.asset("assets/images/download.png", height: 50,)),
                      //     ),
                      //   ),
                      // ),
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
                Visibility(
                  visible: visibilityController,
                    child:WelcomeCard()

                ),
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




