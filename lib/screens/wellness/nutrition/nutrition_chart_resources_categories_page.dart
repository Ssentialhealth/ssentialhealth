import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/utils/constants.dart';

import 'nutrition_resources_content_page.dart';

class NutritionChartResourcesCategoriesPage extends StatelessWidget {
  const NutritionChartResourcesCategoriesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Daily Intake Dietary Guidelines Recommendation",
      "Common foods with their nutrient contents, foods rich in various nutrients",
      "Nutritional Information Charts",
      "Printable Food & Fitness Trackers(Out of app, being sold)",
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Nutrition Chart Resources",
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 16.h),

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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NutritionResourcesContentPage(
                            category: categories[index],
                          ),
                        ),
                      );
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
