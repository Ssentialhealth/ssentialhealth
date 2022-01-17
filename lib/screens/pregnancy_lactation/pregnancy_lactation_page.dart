import 'package:flutter/material.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/pregnancy_lactation_resources.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/unwell_pregnancy_lactation.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/child_card_item.dart';

import 'widgets/info_diagram.dart';
import 'widgets/nutrition_physical_wellness.dart';

class PregnancyLactationPage extends StatefulWidget {
  @override
  _PregnancyLactationPageState createState() => _PregnancyLactationPageState();
}

class _PregnancyLactationPageState extends State<PregnancyLactationPage> {
  final List<String> categories = [
    "assets/images/menstrual_cycle.png",
    'assets/images/normal_pregnancy.png',
    "assets/images/unwell_pregnancy.png",
    'assets/images/mental_wellness.png',
    "assets/images/physical_nutritional_wellness.png",
    'assets/images/pregnancy_resources.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF00FFFF),
        title: Text(
          "Pregnancy & Lactation",
          style: appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // categories
            ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return ChildCardItem(
                  image: category,
                  press: () async {
                    category == "assets/images/menstrual_cycle.png" ||
                            category == 'assets/images/normal_pregnancy.png' ||
                            category == 'assets/images/mental_wellness.png'
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return InfoDiagram(category: category);
                              },
                            ),
                          )
                        : category == "assets/images/physical_nutritional_wellness.png"
                            ? Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return NutritionPhysicalWellness();
                                  },
                                ),
                              )
                            : category == "assets/images/unwell_pregnancy.png"
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UnwellPregnancyLactation();
                                      },
                                    ),
                                  )
                                : category == "assets/images/pregnancy_resources.png"
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PregnancyLactationResources();
                                          },
                                        ),
                                      )
                                    : Container();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
