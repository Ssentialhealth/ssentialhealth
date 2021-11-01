import 'package:flutter/material.dart';
import 'package:pocket_health/screens/wellness/physical_activity/physical_activity_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/child_card_item.dart';

import 'mental/mental_wellness_page.dart';
import 'nutrition/nutrition_chart_resources_categories_page.dart';
import 'nutrition/nutrition_wellness_page.dart';

class WellnessPage extends StatelessWidget {
  const WellnessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "assets/images/wellness_nutrition.png",
      "assets/images/wellness_nutrition_chart_resources.png",
      "assets/images/wellness_physical_activity.png",
      "assets/images/wellness_mental_wellness.png",
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Wellness",
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ChildCardItem(
                    image: categories[index],
                    press: () async {
                      if (index == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NutritionWellnessPage()),
                        );
                      }
                      if (index == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NutritionChartResourcesCategoriesPage()),
                        );
                      }
                      if (index == 2) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PhysicalActivityPage()),
                        );
                      }
                      if (index == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MentalWellnessPage()),
                        );
                      }
                      if (index == 2) {}
                    },
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
