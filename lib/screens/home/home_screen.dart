import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/screens/AdultUnwell/adult_unwell_screens/adult_unwell.dart';
import 'package:pocket_health/screens/child_health/condition/child_health_immunization_screen.dart';
import 'package:pocket_health/screens/facilities/facilities_categories_screen.dart';
import 'package:pocket_health/screens/facilities/insurance_categories_screen.dart';
import 'package:pocket_health/screens/mental_health/mental_health_page.dart';
import 'package:pocket_health/screens/practitioners/practitioners_categories_screen.dart';
import 'package:pocket_health/screens/pregnancy_lactation/pregnancy_lactation_page.dart';
import 'package:pocket_health/screens/wellness/wellness_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/card_item.dart';
import 'package:pocket_health/widgets/category_card.dart';
import 'package:pocket_health/widgets/welcome_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
      {"icon": "assets/icons/mental_health.png", "text": "Mental Health"},
      {"icon": "assets/icons/wellness.png", "text": "Wellness"},
      {"icon": "assets/icons/first_aid.png", "text": "First Aid"},
      {"icon": "assets/icons/health_insurance.png", "text": "Health Insurance"},
    ];

    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF00FFFF));

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFE7FFFF),
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          toolbarHeight: 68,
          centerTitle: true,
          title: Center(
            child: Container(
              height: 60,
              child: Image.asset(
                'assets/images/homelogo.png',
                fit: BoxFit.contain,
              ),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                      child: Container(
                        height: 40,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                                  hintText: "Search for services",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      color: Color(0xFF00FFFF),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      color: Color(0xFF00FFFF),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                color: accentColorDark,
                              ),
                            ),
                          ],
                        ),
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
                      image: "assets/icons/adult.png",
                      text: "Adult Unwell - Check Symptoms &\nConditions",
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
                      image: "assets/icons/child.png",
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
                      image: "assets/icons/pregnancy.png",
                      text: "Pregnancy & Lactation",
                    ),

                    //welcome
                    // Visibility(visible: visibilityController, child: WelcomeCard()),

                    //categories
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                                          'Please Sign In to access this feature.',
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
                                  if (index == 1) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WellnessPage(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => InsuranceCategoriesScreen(),
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
                      image: "assets/icons/doctor.png",
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
                      image: "assets/icons/hospital.png",
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
