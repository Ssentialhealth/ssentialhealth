import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/wellness/physical_activity_page.dart';
import 'package:pocket_health/utils/constants.dart';

import 'nutrition_chart_resources_categories_page.dart';
import 'nutrition_wellness_page.dart';

class WellnessPage extends StatelessWidget {
  const WellnessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Nutrition",
      "Nutrition Chart Resources",
      "Physical Activity",
      "Mental Wellness",
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
              ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 1.h, color: Colors.black26),
                itemCount: categories.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xff00FFFF),
                    ),
                    title: Text(
                      categories[index],
                      style: listTileTitleStyle,
                    ),
                    onTap: () {
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
