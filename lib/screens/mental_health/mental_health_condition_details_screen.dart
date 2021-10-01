import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/mental_health_conditions_model.dart';
import 'package:pocket_health/utils/constants.dart';

class MentalHealthConditionDetailsScreen extends StatefulWidget {
  final MentalHealthConditionsModel condition;

  MentalHealthConditionDetailsScreen({this.condition});

  @override
  _MentalHealthConditionDetailsScreenState createState() => _MentalHealthConditionDetailsScreenState();
}

class _MentalHealthConditionDetailsScreenState extends State<MentalHealthConditionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              widget.condition.overview.split(",").first,
              style: appBarStyle,
            ),
            backgroundColor: Color(0xFF00FFFF),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 382.w,
                    child: Text(
                      widget.condition.overview,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Causes",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 382.w,
                    child: Text(
                      widget.condition.causes,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Symptoms",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 382.w,
                    child: Text(
                      widget.condition.signsAndSymptoms,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Condition",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 382.w,
                    child: Text(
                      widget.condition.condition,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
