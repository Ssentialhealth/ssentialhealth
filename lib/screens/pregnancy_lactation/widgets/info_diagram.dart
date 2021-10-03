import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/pregnancy_lactation_model.dart';
import 'package:pocket_health/utils/constants.dart';

class InfoDiagram extends StatelessWidget {
  final String category;

  const InfoDiagram({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            category,
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Consumer(
            builder: (BuildContext context, ScopedReader watch, widget) {
              final pregModelAsyncVal = watch(pregModelProvider);

              return pregModelAsyncVal.when(
                data: (pregData) => Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    children: [
                      Container(
                        width: 1.sw,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Image(
                          image: AssetImage("assets/images/practitioners_banner.png"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        category == 'Menstrual cycle (Period cycle)'
                            ? pregData.menstrualCycleOrPeriodCycle
                            : category == 'Normal Pregnancy or Lactation'
                                ? pregData.normalPregnancyOrLactation
                                : category == "Mental Wellness"
                                    ?pregData.mentalWellness
                                    : "",
                        softWrap: true,
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                loading: () => Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Container(
                      height: 24.w,
                      width: 24.w,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (err, stack) {
                  print('--------|stack|--------|value -> ${stack.toString()}');
                  return Text(
                    'err',
                    style: TextStyle(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
