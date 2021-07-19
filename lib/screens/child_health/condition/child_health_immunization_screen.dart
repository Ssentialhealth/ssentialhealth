import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/screens/child_health/all_immunization_schedules/all_immunization_schedules_screen.dart';
import 'package:pocket_health/screens/child_health/congenital_conditions/congenital_condition_screen.dart';
import 'package:pocket_health/screens/child_health/nutrition/nutrition_screen.dart';
import 'package:pocket_health/screens/child_health/resource/child_resource_screen.dart';
import 'package:pocket_health/screens/child_health/unwell_child/unwell_child_screen.dart';
import 'package:pocket_health/widgets/child_card_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../growth/growth_milestones_screen.dart';

class CHIScreen extends StatefulWidget {
  const CHIScreen({Key key}) : super(key: key);

  @override
  _CHIScreenState createState() => _CHIScreenState();
}

class _CHIScreenState extends State<CHIScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _token = "...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text(
          "Child Health & Immunization",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            ChildCardItem(
                image: "assets/images/child_unwell.png",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UnwellChildScreen()));
                }),
            ChildCardItem(
                image: "assets/images/immunisation_chart.png",
                press: () async {
                  _token = await getStringValuesSF();
                  if (_token != null) {
	                  _token = await getStringValuesSF();

                    final response = await http.Client().get(
                      Uri.encodeFull("https://ssential.herokuapp.com/api/child_health/immunization_schedule/vaccines/35"),
                      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
                    );
                    print("test" + response.body);
                    print(_token);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllImmunizationSchedulesScreen()));
                  } else {
                    _showErrorSnack("Login To Access This Feature");
                  }
                }),
            ChildCardItem(
                image: "assets/images/growth_and_milestones.png",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GrowthAndMilestones()));
                }),
            ChildCardItem(
                image: "assets/images/child_n.png",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NutritionScreen()));
                }),
            ChildCardItem(
                image: "assets/images/chronic_conditions.png",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CongenitalScreen()));
                }),
            ChildCardItem(
                image: "assets/images/child_resource.png",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChildResourceScreen()));
                }),
          ],
        ),
      ),
    );
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    return stringValue;
  }

  _showErrorSnack(String message) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xff163C4D),
      duration: Duration(milliseconds: 2500),
      content: Text(
        "$message",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.hideCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackbar);
    // setState(() {
    //   _isSubmitting = false;
    // });
  }
}
