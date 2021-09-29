import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/screens/pregnancy_lactation/widgets/pregnancy_lactation_resources.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/unwell_pregnancy_lactation.dart';
import 'package:pocket_health/utils/constants.dart';

import 'widgets/info_diagram.dart';
import 'widgets/nutrition_physical_wellness.dart';

class PregnancyLactation extends StatefulWidget {
  @override
  _PregnancyLactationState createState() => _PregnancyLactationState();
}

class _PregnancyLactationState extends State<PregnancyLactation> {
  String searchQuery = '';
  List<String> filteredCategories = [];
  final List<String> categories = [
    "Menstrual cycle (Period cycle)",
    'Normal Pregnancy or Lactation',
    "Unwell in Pregnancy or Lactation",
    'Mental Wellness',
    "Nutrition and physical wellness",
    "Pregnancy or Lactation resources",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Pregnancy & Lactation",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // search
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: SizedBox(
                      height: 40.h,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        onChanged: (val) async {
                          setState(() {
                            searchQuery = val.toLowerCase();
                            filteredCategories = categories.where((element) => element.toLowerCase().contains(searchQuery)).toList();
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0.w),
                          hintText: "Search for doctor",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // categories
            ListView.separated(
              itemCount: searchQuery.isEmpty ? categories.length : filteredCategories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Divider(
                  height: 0,
                  thickness: 0.0,
                  color: Color(0xffC6C6C6),
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                final category = searchQuery.isEmpty ? categories[index] : filteredCategories[index];
                return ListTile(
                  dense: true,
                  isThreeLine: false,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Color(0xff00FFFF),
                  ),
                  title: Text(
                    category,
                    style: listTileTitleStyle,
                  ),
                  onTap: () async {
                    category == "Menstrual cycle (Period cycle)" || category == 'Normal Pregnancy or Lactation' || category == 'Mental Wellness'
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return InfoDiagram(category: category);
                              },
                            ),
                          )
                        : category == "Nutrition and physical wellness"
                            ? Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return NutritionPhysicalWellness();
                                  },
                                ),
                              )
                            : category == "Unwell in Pregnancy or Lactation"
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UnwellPregnancyLactation();
                                      },
                                    ),
                                  )
                                : category == "Pregnancy or Lactation resources"
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
