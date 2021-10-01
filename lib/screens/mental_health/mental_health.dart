import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/child_card_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mental_health_conditions_page.dart';
import 'mental_health_resources_page.dart';

class MentalHealth extends StatelessWidget {
  const MentalHealth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Mental Health",
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  final bool mentalHealthIsAgreed = prefs.getBool("mentalHealthIsAgreed");
                  final newVal = mentalHealthIsAgreed == null ? await prefs.setBool("mentalHealthIsAgreed", false) : mentalHealthIsAgreed;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MentalHealthConditionsPage(disclaimer: newVal),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/images/mental_health_conditions_banner.png",
                  fit: BoxFit.fitWidth,
                  width: 464.w,
                ),
              ),
              ChildCardItem(
                image: "assets/images/mental_health_consult_specialist.png",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MentalHealthResourcesPage(),
                    ),
                  );
                },
              ),
              ChildCardItem(
                image: "assets/images/mental_health_resources_banner.png",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MentalHealthResourcesPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
