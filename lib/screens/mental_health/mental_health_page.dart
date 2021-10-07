import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/screens/practitioners/practitioners_list_screen.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/child_card_item.dart';

import 'consult_categories.dart';
import 'mental_health_overview_page.dart';
import 'mental_health_resources_page.dart';

class MentalHealthPage extends StatelessWidget {
  const MentalHealthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEAFCF6),
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
              SizedBox(height: 10.h),
              ChildCardItem(
                press: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MentalHealthOverviewPage(),
                    ),
                  );
                },
                image: "assets/images/mental_health_conditions_banner.png",
              ),
              ChildCardItem(
                image: "assets/images/mental_health_consult_specialist.png",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConsultCategories(),
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
