import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/models/nutrition_chart_resources_model.dart';
import 'package:pocket_health/screens/wellness/resource_card.dart';
import 'package:pocket_health/utils/constants.dart';

class NutritionResourcesContentPage extends StatelessWidget {
  final String category;
  const NutritionResourcesContentPage({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Consumer(
              builder: (context, ScopedReader watch, child) {
                final nutritionChartResourcesAsyncValue = watch(nutritionChartResourcesModelProvider);
                final linksAsyncVal = watch(linksModelProvider);

                return nutritionChartResourcesAsyncValue.when(
                  data: (resources) {
                    final filteredResources = resources.where((element) => element.nutritionChartResources == category).toList();
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                      itemCount: filteredResources.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final resource = filteredResources[index];
                        return linksAsyncVal.when(
                          data: (links) {
                            final link = links.lastWhere((element) => element.id == resource.resourceLink);
                            return ResourceCard(link: link);
                          },
                          loading: () => Center(
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: accentColorLight,
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              height: 80.h,
                              width: 380.w,
                              child: Container(
                                height: 20.h,
                                width: 20.h,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
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
                    );
                  },
                  loading: () => Center(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: accentColorLight,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      height: 80.h,
                      width: 380.w,
                      child: Container(
                        height: 20.h,
                        width: 20.h,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
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
        ),
      ),
    );
  }
}
