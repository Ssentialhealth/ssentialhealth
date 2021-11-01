import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/models/physical_activity_model.dart';
import 'package:pocket_health/models/physical_activity_resources_model.dart';
import 'package:pocket_health/screens/wellness/resource_card.dart';
import 'package:pocket_health/utils/constants.dart';

import '../tab_content.dart';

class PhysicalActivityPage extends StatefulWidget {
  const PhysicalActivityPage({Key key}) : super(key: key);

  @override
  _PhysicalActivityPageState createState() => _PhysicalActivityPageState();
}

class _PhysicalActivityPageState extends State<PhysicalActivityPage> {
  final List<String> tabs = ["Physical Activity", "Physical Activity Resources"];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Physical Activity",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),

            //tabs
            Container(
              height: 32.h,
              child: ListView.builder(
                itemCount: tabs.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = index;
                      });
                    },
                    child: Container(
                      height: 32.h,
                      decoration: isSelected == index
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: accentColor,
                              border: Border.all(color: accentColor),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: Colors.white,
                              border: Border.all(color: accentColor),
                            ),
                      padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 8.w),
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        tabs[index],
                        style: isSelected == index
                            ? TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              )
                            : TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //data
            Consumer(
              builder: (context, ScopedReader watch, child) {
                final physicalActivityAsyncVal = watch(physicalActivityModelProvider);
                final physicalActivityResourcesAsyncVal = watch(physicalActivityResourcesModelProvider);
                if (isSelected == 0) {
                  return physicalActivityAsyncVal.when(
                    data: (physicalActivityModel) {
                      return TabContent(
                        overview: physicalActivityModel.physicalActivity,
                        reference: physicalActivityModel.resourceLink,
                      );
                    },
                    loading: () => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    error: (err, stack) {
                      print('--------|stack|--------|value -> ${stack.toString()}');
                      return Text(
                        err.toString(),
                        style: TextStyle(),
                      );
                    },
                  );
                }
                if (isSelected == 1) {
                  return physicalActivityResourcesAsyncVal.when(
                    data: (physicalActivityResources) {
                      final linksAsyncVal = watch(linksModelProvider);

                      final firstSectionResources = physicalActivityResources
                          .where((element) => element.physicalActivityResources == "Recommended exercise physical activity levels")
                          .toList();

                      final secondSectionResources = physicalActivityResources
                          .where((element) =>
                              element.physicalActivityResources == "List with a variety of resources for most fun and physical activities for varied groups")
                          .toList();

                      final thirdSectionResources = physicalActivityResources
                          .where((element) =>
                              element.physicalActivityResources == "Free workout resources for home workouts, includes links to various YouTube channel")
                          .toList();

                      final fourthSectionResources = physicalActivityResources
                          .where((element) => element.physicalActivityResources == "Exercise Resources for children and adult")
                          .toList();

                      final fifthSectionResources = physicalActivityResources
                          .where((element) => element.physicalActivityResources == "Family related physical activity resources")
                          .toList();

                      final sixthSectionResources = physicalActivityResources
                          .where((element) => element.physicalActivityResources == "Physical activity resources in adulthood, aging and chronic conditions")
                          .toList();

                      final seventhSectionResources = physicalActivityResources
                          .where((element) => element.physicalActivityResources == "Wellness in the work place, varied resources")
                          .toList();

                      final eighthSectionResources = physicalActivityResources
                          .where((element) => element.physicalActivityResources == "Comprehensive physical activity and health information guideline")
                          .toList();

                      List<List<PhysicalActivityResourcesModel>> allSections = [];

                      allSections.add(firstSectionResources);
                      allSections.add(secondSectionResources);
                      allSections.add(thirdSectionResources);
                      allSections.add(fourthSectionResources);
                      allSections.add(fifthSectionResources);
                      allSections.add(sixthSectionResources);
                      allSections.add(seventhSectionResources);
                      allSections.add(eighthSectionResources);

                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(height: 1.h, color: Colors.black12),
                        itemCount: allSections.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final sectionResources = allSections[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  index == 0
                                      ? "Recommended exercise physical activity levels"
                                      : index == 1
                                          ? "List with a variety of resources for most fun and physical activities for varied groups"
                                          : index == 2
                                              ? "Free workout resources for home workouts, includes links to various YouTube channel"
                                              : index == 3
                                                  ? "Exercise Resources for children and adult"
                                                  : index == 4
                                                      ? "Family related physical activity resources"
                                                      : index == 5
                                                          ? "Physical activity resources in adulthood, aging and chronic conditions"
                                                          : index == 6
                                                              ? "Wellness in the work place, varied resources"
                                                              : index == 7
                                                                  ? "Comprehensive physical activity and health information guideline"
                                                                  : "",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              //resouce cards
                              ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                                itemCount: sectionResources.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final resource = sectionResources[index];
                                  return linksAsyncVal.when(
                                    data: (links) {
                                      final link = links.lastWhere((element) => element.id == resource.resourceLink);
                                      return ResourceCard(link: link);
                                    },
                                    loading: () => Container(
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                        color: accentColorLight,
                                        borderRadius: BorderRadius.circular(8.w),
                                      ),
                                      height: 80.h,
                                      width: 350.w,
                                      child: Container(
                                        height: 20.h,
                                        width: 20.h,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                    error: (err, stack) {
                                      print('--------|stack|--------|value -> ${stack.toString()}');
                                      return Text(
                                        err.toString(),
                                        style: TextStyle(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    loading: () => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    error: (err, stack) {
                      print('--------|stack|--------|value -> ${stack.toString()}');
                      return Text(
                        err.toString(),
                        style: TextStyle(),
                      );
                    },
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
