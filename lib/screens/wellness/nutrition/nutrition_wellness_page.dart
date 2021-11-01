import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/nutrition_wellness_model.dart';
import 'package:pocket_health/utils/constants.dart';

import '../tab_content.dart';

class NutritionWellnessPage extends StatefulWidget {
  const NutritionWellnessPage({Key key}) : super(key: key);

  @override
  _NutritionWellnessPageState createState() => _NutritionWellnessPageState();
}

class _NutritionWellnessPageState extends State<NutritionWellnessPage> {
  final List<String> tabs = ["Basic", "Food Products", "Weight Gain/Loss"];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Nutrition",
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
                final nutritionWellnessAsyncVal = watch(nutritionWellnessModelProvider);

                return nutritionWellnessAsyncVal.when(
                  data: (nutritionWellnessModel) {
                    print('--------|val|--------|value -> ${nutritionWellnessModel.basicLink.toString()}');

                    if (isSelected == 0) {
                      return TabContent(overview: nutritionWellnessModel.basicOverview, reference: nutritionWellnessModel.basicLink);
                    }
                    if (isSelected == 1) {
                      return TabContent(overview: nutritionWellnessModel.foodProductsOverview, reference: nutritionWellnessModel.foodProductsLink);
                    }
                    if (isSelected == 2) {
                      return TabContent(overview: nutritionWellnessModel.weightGainLossOverview, reference: nutritionWellnessModel.weightGainLossLink);
                    }

                    return SizedBox.shrink();
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
