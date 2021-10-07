import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/screens/AdultUnwell/adult_unwell_screens/adult_unwell.dart';
import 'package:pocket_health/screens/child_health/condition/child_health_immunization_screen.dart';
import 'package:pocket_health/screens/facilities/facilities_categories_screen.dart';
import 'package:pocket_health/screens/mental_health/mental_health_page.dart';
import 'package:pocket_health/screens/practitioners/practitioners_categories_screen.dart';
import 'package:pocket_health/screens/pregnancy_lactation/pregnancy_lactation_page.dart';
import 'package:pocket_health/widgets/card_item.dart';
import 'package:pocket_health/widgets/category_card.dart';
import 'package:pocket_health/widgets/welcome_dart.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _type = "...";
  bool visibilityController = false;

  welcomeCard() {
    setState(() {
      if (_type != null) {
        visibilityController = true;
        return WelcomeCard();
      } else {
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
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/homelogo.png',
              fit: BoxFit.scaleDown,
            ),
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),

                    //search box
                    Container(
                      height: 55,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                cursorColor: Colors.grey,
                                decoration: searchFieldInputDecoration("Search for services"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(onTap: () async {}, child: Icon(Icons.settings)),
                          ),
                        ],
                      ),
                    ),

                    //adult unwell
                    CardItem(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdultUnwell(),
                          ),
                        );
                      },
                      image: "assets/images/adult_unwell.png",
                      text: "Adult Unwell- Check Symptoms \n& Conditions",
                    ),

                    //immunization
                    CardItem(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CHIScreen(),
                          ),
                        );
                      },
                      image: "assets/images/child_health_ immunisation.png",
                      text: "Child Health & Immunisation",
                    ),

                    //pregnancy
                    CardItem(
                      press: () async {
                        final _token = await getStringValuesSF();
                        if (_token == null) {
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xff163C4D),
                                duration: Duration(milliseconds: 6000),
                                content: Text(
                                  'Please Log In to access this feature.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                        } else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PregnancyLactationPage(),
                            ),
                          );
                      },
                      image: "assets/images/pregnancy_lactation.png",
                      text: "Pregnancy & Lactation",
                    ),
                    SizedBox(height: 8),

                    //welcome
                    Visibility(visible: visibilityController, child: WelcomeCard()),
                    SizedBox(height: 8),

                    //categories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            categories.length,
                            (index) => CategoryCard(
                              icon: categories[index]["icon"],
                              text: categories[index]["text"],
                              press: () async {
                                final _token = await getStringValuesSF();
                                if (_token == null) {
                                  ScaffoldMessenger.of(context)
                                    ..clearSnackBars()
                                    ..showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Color(0xff163C4D),
                                        duration: Duration(milliseconds: 6000),
                                        content: Text(
                                          'Please Log In to access this feature.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                } else {
                                  if (index == 0) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MentalHealthPage(),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),

                    //doctors and practitioners
                    CardItem(
                      press: state is LoginLoaded && state.loginModel.user.userCategory == 'individual'
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PractitionersCategoriesScreen();
                                  },
                                ),
                              );
                            }
                          : () {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Color(0xff163C4D),
                                    duration: Duration(milliseconds: 6000),
                                    content: Text(
                                      'This feature is only available to users registered as individuals!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                            },
                      image: "assets/images/doctors_practitioners.png",
                      text: "Doctors & Practitioners",
                    ),

                    //health facilities
                    CardItem(
                      press: state is LoginLoaded && state.loginModel.user.userCategory == 'individual'
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FacilitiesCategoriesScreen();
                                  },
                                ),
                              );
                            }
                          : () {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Color(0xff163C4D),
                                    duration: Duration(milliseconds: 6000),
                                    content: Text(
                                      'This feature is only available to users registered as individuals!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                            },
                      image: "assets/images/hospital_facilities.png",
                      text: "Health Facilities",
                    ),
                  ],
                );
              },
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
