import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/models/mental_health_conditions_model.dart';
import 'package:pocket_health/utils/constants.dart';

import 'mental_health_condition_details_screen.dart';

class MentalHealthConditionsPage extends StatefulWidget {
  @override
  _MentalHealthConditionsPageState createState() => _MentalHealthConditionsPageState();
}

class _MentalHealthConditionsPageState extends State<MentalHealthConditionsPage> {
  @override
  void initState() {
    super.initState();
  }

  String searchQuery = "";
  List<MentalHealthConditionsModel> queriedConditions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Mental Health Conditions",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer(
              builder: (context, ScopedReader watch, child) {
                final mentalHealthConditionsAsyncVal = watch(mentalHealthConditionsModelProvider);
                return mentalHealthConditionsAsyncVal.when(
                  data: (conditions) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        queriedConditions =
                                            conditions.where((element) => element.condition.toLowerCase().contains(searchQuery.toLowerCase())).toList();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0.w),
                                      hintText: "Search for Conditions",
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
                        ListView.builder(
                          itemCount: searchQuery.isEmpty ? conditions.length : queriedConditions.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final condition = searchQuery.isEmpty ? conditions[index] : queriedConditions[index];
                            return ListTile(
                              dense: true,
                              isThreeLine: false,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Color(0xff00FFFF),
                              ),
                              title: Text(
                                condition.condition,
                                style: listTileTitleStyle,
                              ),
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MentalHealthConditionDetailsScreen(
                                      condition: condition,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                  loading: () => Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        height: 24.h,
                        width: 24.h,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  error: (err, stack) {
                    print('--------|mental health err|--------|value -> ${stack.toString()}');
                    return Container(
                      color: Colors.red,
                      width: 200,
                      height: 100,
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
